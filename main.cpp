#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include "mythread.h"
#include <QThread>
#include "network.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;
	qmlRegisterType<NetWork>("CppNetWork", 1, 0, "NetWork");
	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

//	auto t1 = new MyThread();

//	t1->start();

//	auto context = engine.rootContext();


	return app.exec();
}
