--------------------------- MODULE GalsIzhikevich ---------------------------

EXTENDS FiniteSets, Integers

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
                        [   t |-> 0, p |-> 1, c |-> 0   ]
                    ]
                            
Next(n) ==  /\ state[n].t < MAXTIME
            /\ state[n].p > 0
            /\ state' = [ a \in 1..NEURONS |->
                            IF a = n THEN
                                [   t |-> state[a].t + 1,
                                    p |-> state[a].p - 1,
                                    c |-> 0
                                ]
                            ELSE IF a \in OUT_NEIGHBOURS[n] THEN
                                IF Cardinality(IN_NEIGHBOURS[a]) = state[a].c + 1 THEN
                                    [   state[a] EXCEPT 
                                            !.p = 1 + @, 
                                            !.c = 0    
                                    ]
                                ELSE 
                                    [  state[a] EXCEPT !.c = 1 + @  ]
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
                        /\ state[n].t - state[i].t < 2
                        /\ state[n].t - state[i].t > -2     
                    /\ \A o \in OUT_NEIGHBOURS[n]:
                        /\ state[n].t - state[o].t < 2
                        /\ state[n].t - state[o].t > -2
                        
TypeOK  ==  /\  \A n \in 1..NEURONS :
                    /\ state[n].t <= MAXTIME
                    /\ state[n].c <= Cardinality(IN_NEIGHBOURS[n])
            /\  NeighbourOK
            /\  TimeDiffOK
=============================================================================
\* Modification History
\* Last modified Fri Feb 09 12:32:32 UTC 2018 by affan
\* Created Thu Feb 08 19:33:04 UTC 2018 by affan
