------------------------- MODULE GalsSystemIntCells -------------------------
EXTENDS FiniteSets, Integers

CONSTANTS   CELLS,      \* Number of cells
            NEIGHBOURS, \* A tuple of the set of neighbours
                        \* with the index being the cell number
            MAXTIME     \* Maximum time for the systems
            
VARIABLES   state   \* A function with domain the set of cells 
                    \* and range a record with fields cs, ns, t


GSInit  ==  state = [c \in 1..CELLS |-> 
                    [t |-> 0, s |-> << Cardinality(NEIGHBOURS[c]), 0 >>]]  


Next(c) ==  /\ state[c].s[1] = Cardinality(NEIGHBOURS[c])
            /\ state[c].t < MAXTIME
            /\ state' = [i \in 1..CELLS |->
                    IF i = c THEN
                            [   t |-> state[i].t + 1, 
                                s |-> << state[i].s[2], 0>> ] 
                    ELSE IF i \in NEIGHBOURS[c] THEN
                            [ state[i] EXCEPT   
                                    !.s[state[c].t - state[i].t +2] = 1 + @]
                    ELSE
                            state[i]]

GSNext == \E c \in 1..CELLS : Next(c)

GSSpec == GSInit /\ [][GSNext]_<<state>>   

-----------------------------------------------------------------------------
                    
\* Check for two way neighbours
NeighbourOK ==  \A c \in 1..CELLS :
                        \A n \in NEIGHBOURS[c] : c \in NEIGHBOURS[n]
                    
\* Check the time difference is never greater than 1
TimeDiffOK ==   \A c \in 1..CELLS :
                        \A n \in NEIGHBOURS[c] :
                                /\ state[c].t - state[n].t < 2
                                /\ state[c].t - state[n].t > -2
                                
TypeOK ==   /\ \A c \in 1..CELLS : 
                    /\ state[c].t <= MAXTIME
                    /\ state[c].s[1] <= Cardinality(NEIGHBOURS[c])
                    /\ state[c].s[2] <= Cardinality(NEIGHBOURS[c])
            /\ NeighbourOK
            /\ TimeDiffOK                

=============================================================================
\* Modification History
\* Last modified Fri Jan 26 00:18:34 UTC 2018 by affan
\* Created Thu Jan 25 11:31:40 UTC 2018 by affan
