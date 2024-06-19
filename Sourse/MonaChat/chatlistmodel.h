#ifndef QCHATLISTMODEL_H
#define QCHATLISTMODEL_H

#include<QObject>
#include<QAbstractListModel>
#include "monachatstructs.h"

class ChatListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    ChatListModel(QObject* parent=nullptr);
    int rowCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index,int role)const override;
    QHash<int,QByteArray> roleNames()const override;
    //bool setData(const QModelIndex &index, const QVariant &value, int role)override;

public:
    QHash<int,QByteArray> m_roleNames;
    QVector<User> m_listData;
};

#endif // QCHATLISTMODEL_H
