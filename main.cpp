#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>
#include "network.h"
#include "tcpserver.h"
#include "tcpclient.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);

	QFontDatabase::addApplicationFont(":/resource/materialdesignicons-webfont.ttf");

	NetWork network;

	TcpServer tcpServer;
	TcpClient tcpClient;

	auto context = engine.rootContext();
	context->setContextProperty("_network", &network);
	context->setContextProperty("_tcpServer", &tcpServer);
	context->setContextProperty("_tcpClient", &tcpClient);

	qmlRegisterType<TcpServer>("TcpServer", 1, 0, "TcpServer");
	qmlRegisterType<TcpClient>("TcpClient", 1, 0, "TcpClient");

	engine.load(url);
	return app.exec();
}
