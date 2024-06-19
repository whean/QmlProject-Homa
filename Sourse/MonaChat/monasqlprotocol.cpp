#include "monasqlprotocol.h"

void operator<<(QDataStream& stream,OptionType type)
{
    stream << static_cast<quint8>(type);
}

void operator<<(QDataStream& stream,DataType type)
{
    stream << static_cast<quint8>(type);
}

void operator>>(QDataStream& stream,OptionType& type)
{
    quint8 temp;
    stream >> temp;
    type = static_cast<OptionType>(temp);
}

void operator>>(QDataStream& stream,DataType& type)
{
    quint8 temp;
    stream >> temp;
    type = static_cast<DataType>(temp);
}

MonaSqlProtocol::MonaSqlProtocol(quint8 version)
{
    this->version = version;
}


MonaSqlPacket MonaSqlProtocol::packet(OptionType optionType, DataType data_type, DataType return_type, QByteArray data)
{
    MonaSqlPacket packet;
    packet.length = sizeof(packet.length)+sizeof(packet.version)+sizeof (packet.type)
            +sizeof (packet.d_type) + sizeof (packet.r_type) + sizeof (packet.data_len);
    packet.version = version;
    packet.type = optionType;
    packet.d_type = data_type;
    packet.r_type = return_type;
    packet.data = data;
    packet.data_len = sizeof (data);
    return packet;

}

QByteArray MonaSqlProtocol::serialize(const MonaSqlPacket packet)
{
    QByteArray data;
    QDataStream stream(&data,QIODevice::WriteOnly);
    stream << packet.length;
    stream << packet.version;
    stream << packet.type;
    stream << packet.d_type;
    stream << packet.r_type;
    stream << packet.data_len;
    stream << packet.data;

    return data;
}

int MonaSqlProtocol::deserialize(MonaSqlPacket& packet,const QByteArray data)
{
    QDataStream stream(data);
    stream >> packet.length;
    stream >> packet.version;
    stream >> packet.type;
    stream >> packet.d_type;
    stream >> packet.r_type;
    stream >> packet.data_len;
    stream.writeBytes(packet.data,packet.data_len);
    return sizeof(packet);
}
