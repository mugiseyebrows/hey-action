#include "testqstring.h"

#include <QDebug>

void TestQString::toUpper()
{
  qDebug() << "hello from debug";

  printf("hello from printf\n");

  QString str = "Hello";
  QVERIFY(str.toUpper() == "HELLO");
}
