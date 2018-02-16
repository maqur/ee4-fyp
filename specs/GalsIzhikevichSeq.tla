--------------------------- MODULE GalsIzhikevichSeq ---------------------------

EXTENDS FiniteSets, Integers, Sequences

CONSTANTS   NEURONS, 
            IN_NEIGHBOURS, 
            OUT_NEIGHBOURS, 
            MAXTIME

VARIABLES   state

(***************************************************************************)
(* The state variable is a function with domain the set of neurons         *)
(* and range a record with fieds: t (current time or state),               *)
(* p (number of pending fires), c (count of recieved messages) and         *)
(* i (number of input neurons)                                             *)
(***************************************************************************)

GIInit  ==  state = [ n \in 1..NEURONS |->
                        [   t |-> 0, c |-> <<Cardinality(IN_NEIGHBOURS[n])>>   ]
                    ]
                            
\* This next statement assumes that a message sent is instantly received
\* And the sequence of messages sent and received in preserved
\* If the sequences of messages is not preserved than the update for 'c'
\* variable of state[n] need to be changed

Next(n) ==  /\ state[n].t < MAXTIME
            /\ Len(state[n].c) > 0
            /\ state[n].c[1] = Cardinality(IN_NEIGHBOURS[n])
            /\ state' = [ a \in 1..NEURONS |->
                            IF a = n THEN
                                [   t |-> state[a].t + 1,
                                    c |-> Tail(state[a].c)
                                ]
                            ELSE IF a \in OUT_NEIGHBOURS[n] THEN
                                LET tDiff == state[n].t - state[a].t + 2 
                                IN  IF Len(state[a].c) >= tDiff THEN
                                        [   state[a] EXCEPT !.c[tDiff] = 1 + @  ] 
                                    \* If msg for time t does not exit append it
                                    \* the seq must have count for t-1 as
                                    \* a msg for t cannot be recieved before msg for t-1
                                    ELSE 
                                        [   state[a] EXCEPT !.c = Append(@,1)   ]
                            ELSE
                                state[a]
                        ]
                        
GINext  ==  \E n \in 1..NEURONS : Next(n)

GISpec  ==  GIInit /\ [][GINext]_<<state>> 


NeighbourOK ==  \A n \in 1..NEURONS :
                    /\ \A i \in IN_NEIGHBOURS[n] : n \in OUT_NEIGHBOURS[i]
                    /\ \A o \in OUT_NEIGHBOURS[n] : n \in IN_NEIGHBOURS[o]

TimeDiffOK  ==  \A n \in 1..NEURONS :
                    /\ \A i \in IN_NEIGHBOURS[n]:
                        state[n].t - state[i].t < 2
                        
TypeOK  ==  /\  \A n \in 1..NEURONS :
                    /\ state[n].t <= MAXTIME
                    /\ \A t \in 1..Len(state[n].c):
                            state[n].c[t] <= Cardinality(IN_NEIGHBOURS[n])
=============================================================================
\* Modification History
\* Last modified Fri Feb 16 11:02:12 UTC 2018 by affan
\* Created Thu Feb 08 19:33:04 UTC 2018 by affan
