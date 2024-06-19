#include "monachatstructs.h"

void operator>>(QDataStream& stream,User user)
{
    stream>>user.id;
    stream>>user.name;
    stream>>user.status;
    stream>>user.phone;
    stream>>user.email;
    stream>>user.last_login;
}

void operator<<(QDataStream& stream,User user)
{
    stream<<user.id;
    stream<<user.name;
    stream<<user.status;
    stream<<user.phone;
    stream<<user.email;
    stream<<user.last_login;
}

void operator>>(QDataStream& stream,Message message)
{
    stream>>message.sender;
    stream>>message.receiver;
    stream>>message.send_time;
    stream>>message.text;
}

void operator<<(QDataStream& stream,Message message)
{
    stream<<message.sender;
    stream<<message.receiver;
    stream<<message.send_time;
    stream<<message.text;
}
