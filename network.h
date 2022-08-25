#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
//#include <stdint

class NetWork : public QObject
{
	Q_OBJECT
public:
	explicit NetWork(QObject *parent = nullptr);

	Q_INVOKABLE QString getHostIPAddress();

signals:

};

#endif // NETWORK_H
