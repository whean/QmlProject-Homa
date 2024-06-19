#include "messagelistmodel.h"

MessageListModel::MessageListModel(QObject* parent):QAbstractListModel (parent)
{
    int role = Qt::UserRole;
    m_roleNames.insert(role++,"sender");
    m_roleNames.insert(role++,"receiver");
    m_roleNames.insert(role++,"send_time");
    m_roleNames.insert(role++,"text");
}

int MessageListModel::rowCount(const QModelIndex &parent) const
{
    return m_listData.size();
}

QVariant MessageListModel::data(const QModelIndex &index, int role) const
{
    switch (role-Qt::UserRole) {
    case 0:return m_listData.value(index.row()).sender;
    case 1:return m_listData.value(index.row()).receiver;
    case 2:return m_listData.value(index.row()).send_time;
    case 3:return m_listData.value(index.row()).text;
    default:return QVariant();
    }
}

QHash<int, QByteArray> MessageListModel::roleNames() const
{
    return m_roleNames;
}

