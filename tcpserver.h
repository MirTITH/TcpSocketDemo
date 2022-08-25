#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QString>
#include <QTcpSocket>
#include <QTcpServer>
#include <QMap>

class TcpServer : public QObject
{
	Q_OBJECT
public:
	explicit TcpServer(QObject *parent = nullptr);

	Q_INVOKABLE bool listen(uint16_t port);
	Q_INVOKABLE void close();
	Q_INVOKABLE void sendMessageToClient(QString &client_key, QString &message);
	Q_INVOKABLE QString getClientKey(QTcpSocket * client);

	QTcpSocket * getConnectedClient(QString &key);

signals:
	void newMessage(QString key, QString message);
	void clientConnected(QString key);
	void clientDisconnected(QString key);
private slots:
	void onNewConnection();
	void onReadyRead();
	void onDisconnected();

private:
	QTcpServer _server;
	QMap<QString, QTcpSocket *> _clients;
};

#endif // TCPSERVER_H
