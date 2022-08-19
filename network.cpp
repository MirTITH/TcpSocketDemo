#include "network.h"
#include <QNetworkInterface>
#include <QList>
//#include <QGuiApplication>

NetWork::NetWork(QObject *parent)
	: QObject{parent}
{

}

QString NetWork::getHostIPAddress()
{
	auto ipAddresses = QNetworkInterface::allAddresses();
	foreach (auto ipAddress, ipAddresses) {
		if (ipAddress != QHostAddress::LocalHost && ipAddress != QHostAddress::LocalHostIPv6) {
			return ipAddress.toString();
		}
	}

	return "";
}
