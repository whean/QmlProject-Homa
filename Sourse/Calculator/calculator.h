#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QQuickItem>
#include <QStack>
#include <QMap>

class Calculator : public QQuickItem
{
    Q_OBJECT
public:
    explicit Calculator(QQuickItem *parent = nullptr);
    bool isLegal(const QString& str);
    static Calculator* getInstance();

    //static QObject* callBack(QQmlEngine *engine, QJSEngine *scriptEngine);
    Q_INVOKABLE void calculate(QString str);
signals:
    void expressionChanged(QString);
public slots:
public:
    QMap<QChar,int> symbolMaps;
};

#endif // CALCULATOR_H
