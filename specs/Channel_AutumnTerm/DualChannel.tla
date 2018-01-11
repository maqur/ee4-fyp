---------------------------- MODULE DualChannel ----------------------------
EXTENDS Sequences
CONSTANT Message
VARIABLES chan1, chan2, q1, q2

Chan1 == INSTANCE InnerChannel WITH chan <- chan1, q <- q1
Chan2 == INSTANCE InnerChannel WITH chan <- chan2, q <- q2 

Init == /\ Chan1!Init
        /\ Chan2!Init

TypeInvariant ==    /\ Chan1!TypeInvariant
                    /\ Chan2!TypeInvariant
                    
Send1(m) == Chan1!Send(m)

Rcv1 == Chan1!Rcv

Send2(m) == Chan2!Send(m)

Rcv2 == Chan2!Rcv

Next == \/ \E m \in Message : Send1(m)
        \/ Rcv1
        \/ \E m \in Message : Send2(m)
        \/ Rcv2
       
Spec == Init /\ [][Next]_<<chan1,chan2>>
=============================================================================
\* Modification History
\* Last modified Mon Nov 13 00:53:56 GMT 2017 by affan
\* Created Sun Nov 12 23:46:15 GMT 2017 by affan
