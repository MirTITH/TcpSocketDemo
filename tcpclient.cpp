#include "tcpclient.h"
#include <QGuiApplication>

TcpClient::TcpClient(QObject *parent)
	: QObject{parent}
{
	connect(&_client, &QTcpSocket::connected, this, &TcpClient::onConnected);
	connect(&_client, &QTcpSocket::disconnected, this, &TcpClient::onDisconnected);
	connect(&_client, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
	connect(&_client, &QTcpSocket::errorOccurred, this, &TcpClient::onErrorOccurred);
//	connect(&_client, &QTcpSocket::stateChanged, this, &TcpClient::onStateChanged);
}

void TcpClient::connectToHost(const QString &host, const uint16_t port)
{
	qDebug() << "connecting to " << host << ":" << port;
	_client.connectToHost(host, port);
}

void TcpClient::disconnectFromHost()
{
	_client.disconnectFromHost();
}

void TcpClient::sendMessageToHost(QString &message)
{
	_client.write(message.toUtf8());
}

void TcpClient::onConnected()
{
	emit connected();
}

void TcpClient::onDisconnected()
{
	qDebug() << "TcpClient::onDisconnected";
	emit disconnected();
}

void TcpClient::onReadyRead()
{
	emit newMessage(_client.readAll());
}

void TcpClient::onStateChanged(QAbstractSocket::SocketState socketState)
{
	qDebug() << "client state changed to:" << socketState;
}

void TcpClient::onErrorOccurred(QAbstractSocket::SocketError socketError)
{
	emit errorOccurred(socketError);
}
