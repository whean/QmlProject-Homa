#include "chatlistmodel.h"

ChatListModel::ChatListModel(QObject *parent):QAbstractListModel (parent)
{
    int role = Qt::UserRole;
    m_roleNames.insert(role++,"id");
    m_roleNames.insert(role++,"name");
    m_roleNames.insert(role++,"status");
    m_roleNames.insert(role++,"phone");
    m_roleNames.insert(role++,"email");
    m_roleNames.insert(role++,"last_login");
}

int ChatListModel::rowCount(const QModelIndex &parent) const
{
    return m_listData.size();
}

QVariant ChatListModel::data(const QModelIndex &index, int role) const
{
    switch (role-Qt::UserRole) {
    case 0:return m_listData.value(index.row()).id;
    case 1:return m_listData.value(index.row()).name;
    case 2:return m_listData.value(index.row()).status;
    case 3:return m_listData.value(index.row()).phone;
    case 4:return m_listData.value(index.row()).email;
    case 5:return m_listData.value(index.row()).last_login;
    default:return QVariant();
    }
}

QHash<int, QByteArray> ChatListModel::roleNames() const
{
    return m_roleNames;
}
