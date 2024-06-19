#ifndef MONACHATSTRUCTS_H
#define MONACHATSTRUCTS_H

#include<QObject>
#include<QDateTime>
#include<QDataStream>

typedef struct User{
    quint16 id;
    QString name;
    QString status;
    QString phone;
    QString email;
    QDateTime last_login;
}User;

typedef struct Message{
    quint16 sender;
    quint16 receiver;
    QDateTime send_time;
    QString text;
}Message;

void operator>>(QDataStream& stream,User user);

void operator<<(QDataStream& stream,User user);

void operator>>(QDataStream& stream,Message message);

void operator<<(QDataStream& stream,Message message);

#endif // MONACHATSTRUCTS_H
