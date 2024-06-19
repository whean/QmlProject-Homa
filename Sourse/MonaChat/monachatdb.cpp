#include "monachatdb.h"
#include <QDebug>

MonaChatDB::MonaChatDB(QObject *parent) : QObject(parent)
{
    //protocol = new MonaSqlProtocol(1);
    connectDB();
}

MonaChatDB::~MonaChatDB()
{

}

void MonaChatDB::connectDB()
{
    qDebug() << "MonaChatDB::connectDB:Connecting";
    socket = new QTcpSocket();
    connect(socket,SIGNAL(readyRead()),this,SLOT(onReadyRead()));
    socket->connectToHost(databaseAddress,port);
//    if(socket->state() != QAbstractSocket::ConnectedState)
//    {
//        qDebug() << "MonaChatDB::write:There is not connected yet";
//    }
}

MonaChatDB *MonaChatDB::getInstance()
{
 static MonaChatDB instance;
 return &instance;
}

void MonaChatDB::setHost(const QString& address,const quint16 port)
{
    this->databaseAddress = QHostAddress(address);
    this->port = port;
}

void MonaChatDB::write(const QByteArray &data)
{
    if(socket->state() != QAbstractSocket::ConnectedState)
    {
        qDebug() << "MonaChatDB::write:There is not connected yet";
        return;
    }
    socket->write(data,data.size());
}

void MonaChatDB::onReadyRead()
{
    QByteArray data = socket->readAll();
    emit dataReceived(data);
}
