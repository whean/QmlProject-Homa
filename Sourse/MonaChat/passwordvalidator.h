#ifndef QPASSWORDVALIDATOR_H
#define QPASSWORDVALIDATOR_H

#include <QObject>

class PassWordValidator : public QObject
{
    Q_OBJECT
public:
    explicit PassWordValidator(QObject *parent = nullptr);

    bool validate(const QString& username,const QString& password);

signals:

public slots:

};

#endif // QPASSWORDVALIDATOR_H
