----------------------------- MODULE Izhikevich -----------------------------

EXTENDS     FiniteSets, Integers, Sequences

CONSTANTS   Neurons,
            InNeighbours,
            OutNeighbours,
            MaxTime

VARIABLES   state,
            messages

IzInit  ==  /\ state =  [ n \in 1..Neurons |->
                            [   t |-> 0, 
                                c |->   [m \in 0..MaxTime |->
                                            IF m = 0 THEN 
                                                Cardinality(InNeighbours[n])
                                            ELSE 0 ]]]
            /\ messages = {}

\* Store(msg)  ==  messages' = messages \cup {msg}
Fire(n)     ==  /\ state[n].t < MaxTime
                /\ state[n].c[state[n].t] = Cardinality(InNeighbours[n])
                /\ messages' = messages \cup 
                        {   [  in |-> n, 
                               out |-> o, 
                               t |-> state[n].t + 1
                            ] : o \in OutNeighbours[n]}
                /\ state' = [ state EXCEPT
                                ![n].t = state[n].t + 1
                            ]

Receive(msg)    ==  /\ state' = [state EXCEPT ![msg.out].c[msg.t] = 1 + @ ]
                    /\ messages' = messages \ {msg}

IzNext  ==  \/ \E n \in 1..Neurons : Fire(n)
            \/ \E m \in messages : Receive(m)

=============================================================================
\* Modification History
\* Last modified Thu Mar 08 22:14:58 UTC 2018 by affan
\* Created Thu Mar 08 18:39:43 UTC 2018 by affan
