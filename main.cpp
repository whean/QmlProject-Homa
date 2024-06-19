#include <QGuiApplication>
#include<QQuickView>
#include<QQmlApplicationEngine>
#include<QQmlContext>
#include <QTextCodec>
#include "monachatcontroller.h"
#include "pagecontroller.h"
#include "musiclistmodel.h"
#include "calculator.h"
#include "settingcontroller.h"
#include <QImageWriter>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Some organization");

    PageController* pageController = PageController::getInstance();
    SettingController* settingController = SettingController::getInstance();
    Calculator* calculator = Calculator::getInstance();
    MonaChatController* monaChatController = MonaChatController::getInstance();

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/Resourse/Image/HomaMonster/WildHoma_normal.png"));

    QTextCodec* code = QTextCodec::codecForName("UTF-8");
    QTextCodec::setCodecForLocale(code);

    qDebug()<<QImageWriter::supportedImageFormats();
    qmlRegisterType<MusicListModel>("SW.models",1,0,"MusicListModel");
    qmlRegisterUncreatableType<PageController>("SW.PageController.enums",1,0,"PageController",QStringLiteral("Access to enum"));
    qmlRegisterUncreatableType<SettingController>("SW.SettingController.enums",1,0,"SettingController",QStringLiteral("Access to enum"));

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("$pageController",pageController);
    engine.rootContext()->setContextProperty("$settingController",settingController);
    engine.rootContext()->setContextProperty("$calculator",calculator);
    engine.rootContext()->setContextProperty("$monaChatController",monaChatController);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
