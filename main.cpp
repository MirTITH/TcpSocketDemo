#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include "mythread.h"
#include <QThread>
#include <QFontDatabase>
#include "network.h"

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
	qmlRegisterType<NetWork>("CppNetWork", 1, 0, "NetWork");



//	auto t1 = new MyThread();

//	t1->start();

//	auto context = engine.rootContext();

	engine.load(url);
	return app.exec();
}
