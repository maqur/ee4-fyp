---------------------------- MODULE InnerChannel ----------------------------
EXTENDS Sequences
CONSTANT Message
VARIABLES chan, q

----------------------------------------------------------------------------

TypeInvariant   ==  /\ chan \in [msg: Message, canSend: BOOLEAN]
                    /\ q \in Seq(Message)

Init    ==  /\ TypeInvariant
            /\ chan.canSend = TRUE
            /\ q = <<>>
        

Send(m) ==  IF chan.canSend
                THEN    /\ chan.msg = m
                        /\ chan.canSend = FALSE
                        /\ UNCHANGED q
                        
                ELSE    /\ q' = Append(q, m)
                        /\ UNCHANGED <<chan>>
            
Rcv ==  IF q = <<>>
            THEN    /\ ~chan.canSend
                    /\ chan' = [chan EXCEPT !.canSend = TRUE]
                    /\ UNCHANGED <<q>>
            
            ELSE    /\ ~chan.canSend
                    /\ chan' = [chan EXCEPT !.msg = Head(q)]
                    /\ q' = Tail(q)

         
Next    ==  \/ \E m \in Message : Send(m)
            \/ Rcv

Spec    ==  Init /\ [][Next]_<<chan,q>>


=============================================================================
\* Modification History
\* Last modified Mon Nov 13 00:09:13 GMT 2017 by affan
\* Created Mon Nov 13 00:03:53 GMT 2017 by affan
