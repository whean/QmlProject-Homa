#ifndef QMONACHATCONTROLLER_H
#define QMONACHATCONTROLLER_H

#include <QObject>
#include <QRegExp>
#include <QCryptographicHash>
#include "messagelistmodel.h"
#include "chatlistmodel.h"
#include "monachatdb.h"
#include "monasqlprotocol.h"
#include "monachatstructs.h"



class MonaChatController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool autoLogin MEMBER m_autoLogin)
    Q_PROPERTY(User user READ getUser())

private:
    explicit MonaChatController(QObject *parent = nullptr);
    ~MonaChatController();
    QString getCryptographic(const QString& password);
    bool isRexExpsValid();
    bool isConnected();

signals:
    void updateMonaChatModel();
    void updateMessageListModel();
    void sigShowDialog(QString text,QString detail = "");


public:
    static MonaChatController* getInstance();
    User getUser();


private slots:
    void onDataReceived(QByteArray data);

public slots:
    void showDialog(QString text,QString detail = "");
    void login(const QString& loginValue,const QString& password);
    void setup(const QString& name,const QString& password,const QString& phone="",const QString& email="");
    void getInfo(const quint16& id);
    void getMessageList(const quint16& id);
    void getChatList(const quint16& id);

public:
    MonaChatDB* db;
    MonaSqlProtocol* protocol;
    ChatListModel* chatModel;
    MessageListModel* messageModel;
    bool m_autoLogin;
    QRegExp regPhone;
    QRegExp regEmail;
    QRegExp regName;
    User current_user;
    QVector<User> friends;
};

#endif // QMONACHATCONTROLLER_H
