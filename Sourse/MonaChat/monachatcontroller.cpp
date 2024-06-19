#include "monachatcontroller.h"

MonaChatController::MonaChatController(QObject *parent) : QObject(parent)
{
    db = MonaChatDB::getInstance();
    chatModel = new ChatListModel();
    messageModel = new MessageListModel();
    protocol = new MonaSqlProtocol(1);
    regPhone = QRegExp("[0-9]{11}");
    regEmail = QRegExp("[\\w]+(.[\\w]+)*@[\\w]+(.[\\w])+");
    regName = QRegExp("[\\S]{6,10}");
    connect(db,SIGNAL(dataReceived(QByteArray)),this,SLOT(onDataReceived(QByteArray)));
}

MonaChatController::~MonaChatController()
{

}

QString MonaChatController::getCryptographic(const QString &password)
{
    QByteArray pwData = password.toUtf8();
    pwData = QCryptographicHash::hash(pwData,QCryptographicHash::Md5);
    return pwData.toHex();
}

bool MonaChatController::isRexExpsValid()
{
    if(!regPhone.isValid())
    {
        qDebug() << "MonaChatController::login:The login regexp is not valid";
        return false;
    }
    if(!regPhone.isValid())
    {
        qDebug() << "MonaChatController::login:The email regexp is not valid";
        return false;
    }
    if(!regName.isValid())
    {
        qDebug() << "MonaChatController::login:The name regexp is not valid";
        return false;
    }
    return true;
}

bool MonaChatController::isConnected()
{
    if(!db->isConnected)
    {
        emit sigShowDialog("未连接到服务器");
    }
    return db->isConnected;
}

MonaChatController *MonaChatController::getInstance()
{
    static MonaChatController instance;
    return &instance;
}

struct User MonaChatController::getUser()
{
    return current_user;
}

void MonaChatController::onDataReceived(QByteArray data)
{
    MonaSqlPacket packet;
    protocol->deserialize(packet,data);
    QDataStream stream(&packet.data,QIODevice::ReadOnly);
    switch (packet.type) {
    case Login:
    {
        if(packet.data.size()>=0&&packet.d_type==DataType_User)
        {
            User user;
            stream >> user;
            current_user = user;
            emit sigShowDialog("登录成功");
        }
        else if(packet.data.size()>=0&&packet.d_type==DataType_Bool)
        {
            bool isSucceed;
            stream>>isSucceed;
            emit sigShowDialog(isSucceed?"登录成功":"登录失败");
        }
        else{
            qDebug() <<"MonaChatController::onDataReceived:Login failed";
        }
        break;
    }
    case Setup:
    {
        if(packet.data.size()>=0&&packet.d_type==DataType_Bool)
        {
            bool isSucceed;
            stream>>isSucceed;
            emit sigShowDialog(isSucceed?"注册成功":"注册失败");
        }
        else{
            qDebug() <<"MonaChatController::onDataReceived:Error occured in setting up";
        }

        break;
    }
    case GetInfos:
    {
        if(packet.data.size()>=0&&packet.d_type==DataType_User)
        {
            User user;
            stream >> user;
        }
        else{
            emit sigShowDialog("获取用户信息失败");
            qDebug() <<"MonaChatController::onDataReceived:GetInfo failed";
        }
        break;
    }
    case GetContacts:
    {
        if(packet.data.size()>=0&&packet.d_type==DataType_UserList)
        {
            QVector<User> users;
            stream >> users;
            chatModel->m_listData = users;
        }
        else{
            emit sigShowDialog("获取好友信息失败");
            qDebug() <<"MonaChatController::onDataReceived:GetContacts failed";
        }
        break;
    }
    case GetMessages:
    {
        if(packet.data.size()>=0&&packet.d_type==DataType_MessageList)
        {
            QVector<Message> messages;
            stream >> messages;
            messageModel->m_listData = messages;
        }
        else{
            emit sigShowDialog("获取消息失败");
            qDebug() <<"MonaChatController::onDataReceived:GetMessage failed";
        }
        break;
    }
    default:
    {
        qDebug() << "MonaChatController::onDataReceived:Unknowed type of received data";
    }
    }
}

void MonaChatController::showDialog(QString text, QString detail)
{
    emit sigShowDialog(text,detail);
}

void MonaChatController::login(const QString &loginValue, const QString &password)
{
    QString cryPw = getCryptographic(password);
    if(!isRexExpsValid()||!isConnected())
        return;
    if(regPhone.exactMatch(loginValue))
    {
        qDebug() << "MonaChatController::login:The login value is a phone number";
        QString opt = QString("-p %1 -pw %2").arg(loginValue).arg(cryPw);
        MonaSqlPacket packet = protocol->packet(Login,DataType_String,DataType_User,opt.toUtf8());
        db->write(protocol->serialize(packet));
    }
    else if(regEmail.exactMatch(loginValue))
    {
        qDebug() << "MonaChatController::login:The login value is a email";
        QString opt = QString("-m %1 -pw %2").arg(loginValue).arg(cryPw);
        MonaSqlPacket packet = protocol->packet(Login,DataType_String,DataType_User,opt.toUtf8());
        db->write(protocol->serialize(packet));
    }
    else if(regName.exactMatch(loginValue))
    {
        qDebug() << "MonaChatController::login:The login value is a username";
        QString opt = QString("-n %1 -pw %2").arg(loginValue).arg(cryPw);
        MonaSqlPacket packet = protocol->packet(Login,DataType_String,DataType_User,opt.toUtf8());
        db->write(protocol->serialize(packet));
    }
    else
    {
        qDebug() << "MonaChatController::login:No match login information";
    }
}

void MonaChatController::setup(const QString &name, const QString &password, const QString &phone, const QString &email)
{
    bool hasPhone =phone.length() > 0;
    bool hasEmail = email.length() >0;
    QString cryPw = getCryptographic(password);
    if(!isRexExpsValid()||!isConnected())
        return;
    if(!regName.exactMatch(name))
    {
        qDebug() << "MonaChatController::setup:illegal username";
        return;
    }
    if(!regPhone.exactMatch(phone)&&hasPhone)
    {
        qDebug() << "MonaChatController::setup:illegal phone number";
        return;
    }
    if(!regEmail.exactMatch(email)&&hasEmail)
    {
        qDebug() << "MonaChatController::setup:illegal email";
        return;
    }
    QString opt = QString("setup -n %1 -pw %2").arg(name).arg(cryPw);
    if(hasPhone)
        opt += QString(" -p %1").arg(phone);
    if(hasEmail)
        opt += QString(" -e %2").arg(email);
    MonaSqlPacket packet  = protocol->packet(Setup,DataType_String,DataType_Bool,opt.toUtf8());
    db->write(protocol->serialize(packet));
}

void MonaChatController::getInfo(const quint16 &id)
{
    if(!isConnected())
        return;
    QString opt = QString("getinfo -i %1").arg(id);
    MonaSqlPacket packet = protocol->packet(GetInfos,DataType_String,DataType_User,opt.toUtf8());
    db->write(protocol->serialize(packet));

}

void MonaChatController::getMessageList(const quint16 &id)
{
    if(!isConnected())
        return;
    QString opt = QString("getmessages %1 -i %2").arg(current_user.id).arg(id);
    MonaSqlPacket packet = protocol->packet(GetMessages,DataType_String,DataType_MessageList,opt.toUtf8());
    db->write(protocol->serialize(packet));
}

void MonaChatController::getChatList(const quint16 &id)
{
    if(!isConnected())
        return;
    QString opt = QString("getmessages %1").arg(id);
    MonaSqlPacket packet = protocol->packet(GetMessages,DataType_String,DataType_UserList,opt.toUtf8());
    db->write(protocol->serialize(packet));
}





