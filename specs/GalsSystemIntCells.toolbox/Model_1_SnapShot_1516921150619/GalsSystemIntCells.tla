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

\* Send(c) ==	/\ state[c].s[1] = Cardinality(NEIGHBOURS[c])
\*             /\ state[c].t < MAXTIME
\*             /\ \A n \in NEIGHBOURS[c] :
\*                         state' = [state EXCEPT 
\*                                     ![c].t = 1 + @, 
\*                                     ![c].s = << state.c.s[1], 0 >>,
\*                                     ![n].s[state[c].t - state[n].t + 2] = @ + 1]
                   
GSNext ==	\E c \in 1..CELLS :  
                    /\ state[c].s[1] = Cardinality(NEIGHBOURS[c])
                    /\ state[c].t < MAXTIME
                    /\ state' = [ state EXCEPT 
                                        ![c].t = 1 + @]
\*                                        \A n \in NEIGHBOURS[c]:
\*                                            ![n].s[2] = 1 + @ ]
                                            
                            
                    \* /\ \A n \in NEIGHBOURS[c] :
                    \*         state' = [state EXCEPT 
                    \*                         ![c].t = 1+@,
                    \*                         ![n].s[2] = 1+@]
                    \* /\ state' = [state EXCEPT ![c].t = 1+@]
                    \* /\ \A n \in NEIGHBOURS[c] :
                    \*         state' = [state EXCEPT 
                    \*                 ![c].t = 1 + @, 
                    \*                 ![c].s = << state.c.s[1], 0 >>,
                    \*                 ![n].s[state[c].t - state[n].t + 2] = @ + 1]

\* GSNext == \E c \in 1..CELLS : Send(c)

GSSpec == GSInit /\ [][GSNext]_<<state>>   
                    
\* \* Check for two way neighbours
\* NeighbourOK ==  \A c \in 1..CELLS :
\*                         \A n \in NEIGHBOURS[c] : c \in NEIGHBOURS[n]
\*                     
\* \* Check the time difference is never greater than 1
\* TimeDiffOK ==   \A c \in 1..CELLS :
\*                         \A n \in NEIGHBOURS.c :
\*                                 /\ state[c].t - state[n].t < 2
\*                                 /\ state[c].t - state[n].t > -2
\*                                 
\* TypeOK ==   /\ \A c \in 1..CELLS : 
\*                     /\ state[c].t <= MAXTIME
\*                     /\ state[c].cs <= Cardinality(NEIGHBOURS[c])
\*                     /\ state[c].ns <= Cardinality(NEIGHBOURS[c])
\*             /\ NeighbourOK
\*             /\ TimeDiffOK                

=============================================================================
\* Modification History
\* Last modified Thu Jan 25 22:59:00 UTC 2018 by affan
\* Created Thu Jan 25 11:31:40 UTC 2018 by affan
