#include "testqstring.h"

#include <QDebug>

void TestQString::toUpper()
{
    QString str = "hello";
  QVERIFY(str.toUpper() == "HELLO");
  fflush(stdout);
  fflush(stderr);
}
