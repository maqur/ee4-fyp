----------------------------- MODULE GalsSystem -----------------------------
EXTENDS     FiniteSets, Naturals

CONSTANTS   CELLS,      \* A set of cells
            NEIGHBOURS, \* A record with each cell being a field 
                        \* whose elements are a set of its neighbours
            MAXTIME     \* Maximum time for the systems
            
VARIABLES   state       \* A function with domain the set of cells 
                        \* and range a record with fields cs, ns, t
                        
\* Check for two way neighbours
NeighbourOK ==  \A c \in CELLS :
                        \A n \in NEIGHBOURS.c : c \in NEIGHBOURS.n
                    
\* Check the time difference is never greater than 1
TimeDiffOK ==   \A c \in CELLS :
                        \A n \in NEIGHBOURS.c :
                                /\ state.c.t - state.n.t < 2
                                /\ state.c.t - state.n.t > 0-2
                                
TypeOK ==   /\ \A c \in CELLS : 
                    /\ state.c.t <= MAXTIME
                    /\ state.c.cs <= Cardinality(NEIGHBOURS.c)
                    /\ state.c.ns <= Cardinality(NEIGHBOURS.c)
            /\ NeighbourOK
            /\ TimeDiffOK                

GSInit  ==  state = [c \in CELLS |-> 
                    [t |-> 0, cs |-> Cardinality(NEIGHBOURS.c), ns |-> 0]]  
\*\A c \in CELLS : state[c] = [t:0 , cs: Cardinality(NEIGHBOURS.c), ns:0]
\*                                /\ state.c = [t:0 , cs: Cardinality(NEIGHBOURS.c), ns:0]
\*                                /\ state.c.cs = Cardinality(NEIGHBOURS.c)
\*                                /\ state.c.ns = 0

\* Assume that a sent message is recieved by its neighbours is a single step
Send(c) ==  \* Check if the cell is blocked
            /\ state[c].cs = Cardinality(NEIGHBOURS.c)
            \* Only send if the system has not reached max time 
            /\ state[c].t < MAXTIME
            \* Update the state of the cell
            /\ [state EXCEPT ![c].t = 1 + @, ![c].cs = state.c.ns, ![c].ns = 0]
            \* Update the message count for the neighbours
            /\ \A n \in NEIGHBOURS.c :
                    IF state[n].t = state[n].t + 1 THEN
                        [state EXCEPT ![n].cs = @ + 1]
                    ELSE [state EXCEPT ![n].ns = @ + 1] 
                   
GSNext == \E c \in CELLS : Send(c)

GSSpec == GSInit /\ [][GSNext]_<<state>>   
                    
=============================================================================
\* Modification History
\* Last modified Thu Mar 01 17:34:39 UTC 2018 by affan
\* Created Mon Jan 08 11:40:06 GMT 2018 by affan
