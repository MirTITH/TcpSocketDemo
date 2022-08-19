#include "mythread.h"
#include <QGuiApplication>

MyThread::MyThread(QObject *parent)
	: QThread{parent}
{

}

void MyThread::run()
{
	qDebug() << "starting " << QThread::currentThread();
	QThread::sleep(2);
	qDebug() << "end " << QThread::currentThread();
}
