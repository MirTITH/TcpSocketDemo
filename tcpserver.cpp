#include "tcpserver.h"
#include <QGuiApplication>

TcpServer::TcpServer(QObject *parent)
	: QObject{parent}
{
	qDebug() << __FUNCTION__ << " created";

	connect(&_server, &QTcpServer::newConnection, this, &TcpServer::onNewConnection);
}

bool TcpServer::listen(uint16_t port)
{
	bool result = _server.listen(QHostAddress::Any, port);
	qDebug() << "server listening to port:" << _server.serverPort();
	return result;
}

void TcpServer::close()
{
	qDebug() << "server closed";
	_server.close();
}

void TcpServer::sendMessageToClient(QString &client_key, QString &message)
{
	const auto client = getConnectedClient(client_key);

	if (client == nullptr)
	{
		return;
	}

	client->write(message.toUtf8());
}

QString TcpServer::getClientKey(QTcpSocket *client)
{
	return client->peerAddress().toString() + ":" + QString::number(client->peerPort());
}

QTcpSocket *TcpServer::getConnectedClient(QString &key)
{
	return _clients.value(key);
}

void TcpServer::onNewConnection()
{
	const auto client = _server.nextPendingConnection();

	if(client == nullptr)
	{
		return;
	}

	const auto client_key = getClientKey(client);

	_clients.insert(client_key, client);
	emit clientConnected(client_key);

	connect(client, &QTcpSocket::readyRead, this, &TcpServer::onReadyRead);
	connect(client, &QTcpSocket::disconnected, this, &TcpServer::onDisconnected);

	qDebug() << "All connected clients:";
	foreach (auto client, _clients) {
		qDebug() << getClientKey(client);
	}
}

void TcpServer::onReadyRead()
{
	const auto client = qobject_cast<QTcpSocket *>(sender());

	if (client == nullptr) {
		return;
	}

	const QString message = client->readAll();

	emit newMessage(getClientKey(client), message);
}

void TcpServer::onDisconnected()
{
	const auto client = qobject_cast<QTcpSocket *>(sender());

	if (client == nullptr) {
		return;
	}

	const auto client_key = getClientKey(client);

	emit clientDisconnected(client_key);
	_clients.remove(client_key);
	client->deleteLater();


	qDebug() << client_key << "disconnected";
	qDebug() << "All connected clients:";
	foreach (auto client, _clients) {
		qDebug() << getClientKey(client);
	}
}

