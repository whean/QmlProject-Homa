#include "calculator.h"

Calculator::Calculator(QQuickItem *parent) : QQuickItem(parent)
{
    symbolMaps.insert('+',0);
    symbolMaps.insert('-',0);
    symbolMaps.insert('%',1);
    symbolMaps.insert('x',2);
    symbolMaps.insert('/',2);
    symbolMaps.insert('@',INT_MIN);
}

bool Calculator::isLegal(const QString &str)
{
    bool isNumber;
    str.toDouble(&isNumber);
    if(isNumber)   //如果是全是数字
        return false;
    if(!str[0].isNumber()||!str[str.length()-1].isNumber())  //如果不以数字开头或结尾
    {
        if(!str.startsWith("-")&&!str.startsWith("+"))
            return false;
    }
    for(int i=1;i<str.length();i++)   //如果连续出现符号
    {
        if(!str[i].isNumber())
            if(!str[i-1].isNumber())
                return false;
    }
    return true;
}

Calculator *Calculator::getInstance()
{
    static Calculator instance;
    return &instance;

}

//QObject *Calculator::callBack(QQmlEngine *engine, QJSEngine *scriptEngine)
//{
//    Q_UNUSED(engine)
//    Q_UNUSED(scriptEngine)

//    return  getInstance();
//}

void Calculator::calculate(QString str)
{

    if(str.isEmpty())
        return;
    if(!isLegal(str))
    {
        emit expressionChanged("0");
        return;
    }
    qDebug() << "Calculator::calculate:The expression is "<< str;
    QStack<double> numbers;   //1+4
    QStack<QChar> symbols;
    QString num;
    str+="@";
    foreach(auto s,str)
    {
        qDebug() << "Calculator::calculate: "<< s;
        if(s.isNumber()||s =='.')
        {
            num +=s;
            qDebug() << QString("Calculator::calculate:add %1 to numbers ").arg(s);

        }
        else
        {
            bool isNum;
            double number = num.toDouble(&isNum);
            if(!isNum)
            {
                qDebug() << "Calculator::calculate: expression is illegal,too many \".\"";
                emit expressionChanged("0");
                return;
            }
            numbers.push(number);
            qDebug() << "Calculator::calculate:The top of numbers is "<< numbers.top();
            num.clear();
            while(!symbols.isEmpty()&&symbolMaps.value(s)<=symbolMaps.value(symbols.top()))
            {
                //                qDebug() << symbolMaps.value('+') << symbolMaps.value(symbols.top('x'));
                qDebug() << "Calculator::calculate:The top of symbols is "<< symbols.top();
                if(symbols.top()=='x')
                {
                    double num_1 = numbers.pop();
                    double num_2 = numbers.pop();
                    numbers.push(num_1*num_2);
                    qDebug() << QString("Calculator::calculate:%1 x %2 = %3 ").arg(num_2).arg(num_1).arg(num_2*num_1);
                }
                else if(symbols.top()=='/')
                {
                    double num_1 = numbers.pop();
                    double num_2 = numbers.pop();
                    numbers.push(num_2/num_1);
                    qDebug() << QString("Calculator::calculate:%1 / %2 = %3 ").arg(num_2).arg(num_1).arg(num_2/num_1);
                }
                else if(symbols.top()=='%')
                {
                    int num_1 = static_cast<int>(numbers.pop());
                    int num_2 = static_cast<int>(numbers.pop());
                    numbers.push(num_2%num_1);
                    //qDebug() << QString("Calculator::calculate:%1 / %2 = %3 ").arg(num_2).arg(num_1).arg(num_2/num_1);
                }
                else if(symbols.top()=='+')
                {
                    double num_1 = numbers.pop();
                    double num_2 = numbers.pop();
                    numbers.push(num_1+num_2);
                    qDebug() << QString("Calculator::calculate:%1 + %2 = %3 ").arg(num_2).arg(num_1).arg(num_2+num_1);
                }
                else if(symbols.top()=='-')
                {
                    double num_1 = numbers.pop();
                    double num_2 = numbers.pop();
                    numbers.push(num_2-num_1);
                    qDebug() << QString("Calculator::calculate:%1 - %2 = %3 ").arg(num_2).arg(num_1).arg(num_2-num_1);
                }
                symbols.pop();
            }

            symbols.push(s);
            qDebug() << QString("Calculator::calculate:add %1 to symbols ").arg(s);
        }
    }
    qDebug() << "Calculator::calculate:The answer is "<< numbers.top();
    emit expressionChanged(QString().setNum(numbers.top()));
}
