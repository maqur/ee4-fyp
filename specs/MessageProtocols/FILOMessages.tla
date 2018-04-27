---- MODULE FILOMessages ----

EXTENDS     FiniteSets, Integers, Sequences

InitMsg ==  <<>>

SendMsg(msgQueue, msg) ==   Append(msgQueue, msg)   

MsgAvailable(msgQueue) == 
        Len(msgQueue) > 0 /\ Cardinality(Head(msgQueue)) > 0

GetMsg(msgQueue) == CHOOSE m \in Head(msgQueue) : TRUE

RemoveMsg(msgQueue, msg) == 
        IF msg \in Head(msgQueue) THEN
            IF Cardinality(Head(msgQueue)) = 1 THEN
                Tail(msgQueue)
            ELSE 
                << Head(msgQueue) \ {msg} >> \o Tail(msgQueue)   
        ELSE
            msgQueue

====
