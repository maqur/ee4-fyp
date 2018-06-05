---- MODULE RandMessages ----

EXTENDS FiniteSets, Integers

InitMsg == {}

SendMsg(msgQueue, msg) == msgQueue \cup msg

MsgAvailable(msgQueue) == Cardinality(msgQueue) > 0

GetMsg(msgQueue) == msgQueue

RemoveMsg(msgQueue, msg) == msgQueue \ {msg}

====
