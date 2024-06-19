#ifndef QMESSAGELISTMODEL_H
#define QMESSAGELISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include "monachatstructs.h"

class MessageListModel : public QAbstractListModel
{
public:
    MessageListModel(QObject* parent=nullptr);
    int rowCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index,int role)const override;
    QHash<int,QByteArray> roleNames()const override;
  //  bool setData(const QModelIndex &index, const QVariant &value, int role)override;


public:
    QHash<int,QByteArray> m_roleNames;
    QVector<Message> m_listData;

    // QAbstractItemModel interface


};

#endif // QMESSAGELISTMODEL_H
