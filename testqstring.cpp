#include "testqstring.h"

#include <QDebug>
#include "debugapi.h"

void TestQString::toUpper()
{
    QString str = "hello";
  QVERIFY(str.toUpper() == "HELLO");


  OutputDebugStringA("Hello world\n");

}
