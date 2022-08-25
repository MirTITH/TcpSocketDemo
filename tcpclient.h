#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QString>

class TcpClient : public QObject
{
	Q_OBJECT
public:
	explicit TcpClient(QObject *parent = nullptr);

	Q_INVOKABLE void connectToHost(const QString &host,const uint16_t port);
	Q_INVOKABLE void disconnectFromHost();
	Q_INVOKABLE void sendMessageToHost(QString &message);

public slots:
	void onConnected();
	void onDisconnected();
	void onReadyRead();
	void onStateChanged(QAbstractSocket::SocketState socketState);
	void onErrorOccurred(QAbstractSocket::SocketError socketError);

signals:
	void connected();
	void disconnected();
	void newMessage(QString message);
	void errorOccurred(QAbstractSocket::SocketError socketError);

private:
	QTcpSocket _client;
};

#endif // TCPCLIENT_H
