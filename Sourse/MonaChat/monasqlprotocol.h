#ifndef MONASQLPROTOCOL_H
#define MONASQLPROTOCOL_H

#include<QObject>
#include<QDataStream>

enum OptionType:quint8{
    Login,
    Setup,
    GetInfos,
    GetContacts,
    GetMessages
};

enum DataType:quint8{
    DataType_User,
    DataType_UserList,
    DataType_Message,
    DataType_MessageList,
    DataType_String,
    DataType_Bool
};

struct MonaSqlPacket{
    quint16 length;
    quint8 version;
    OptionType type;
    DataType d_type;
    DataType r_type;
    quint16 data_len;
    QByteArray data;
};

class MonaSqlProtocol
{

public:
    MonaSqlProtocol(quint8 version);

    MonaSqlPacket packet(OptionType optionType,DataType data_type,DataType return_type,QByteArray data);

    QByteArray serialize(const MonaSqlPacket packet);

    int deserialize(MonaSqlPacket& packet,const QByteArray data);

private:
    quint8 version;

};

#endif // MONASQLPROTOCOL_H
