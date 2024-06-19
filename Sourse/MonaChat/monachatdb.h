#ifndef QMONACHATDB_H
#define QMONACHATDB_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>


class MonaChatDB : public QObject
{
    Q_OBJECT
public:
    explicit MonaChatDB(QObject *parent = nullptr);
    ~MonaChatDB();

    void connectDB();

    static MonaChatDB* getInstance();

    void setHost(const QString& address,const quint16 port);

    void write(const QByteArray& data);
   // void write(const QString& option);
signals:
    void dataReceived(QByteArray data);

private slots:
    void onReadyRead();

public:
    bool hasError;
    QString strError;
    bool isConnected = false;
    QTcpSocket* socket;

private:
    QHostAddress databaseAddress = QHostAddress("localHost");
    quint16 port = 9090;
   // MonaSqlProtocol* protocol;
};

#endif // QMONACHATDB_H
