---- MODULE RandomOrderMessages ----

EXTENDS     FiniteSets, Integers

InitMsg ==  {}

SendMsg(msgQueue, msg) ==   msgQueue \cup msg   

MsgAvailable(msgQueue) ==   Cardinality(msgQueue) > 0

GetMsg(msgQueue) == CHOOSE m \in msgQueue : TRUE

RemoveMsg(msgQueue, msg) == msgQueue \ {msg}

====
