----------------------------- MODULE GalsSystem -----------------------------
EXTENDS     FiniteSets, Naturals

CONSTANTS   CELLS,      \* Set of cells
            NEIGHBORS,  \* A record with each cell being a field and the elements are a set of its neighbors
            MAXTIME     \* Maximum time for the systems
VARIABLES   state       \* A record with cells as fields containing a record with fields cs, ns, t

GSInit  ==  \A c \in CELLS :    /\ state.c.t = 0
                                /\ state.c.cs = Cardinality(NEIGHBORS.c)
                                /\ state.c.ns = 0

\* Assume that as soon as a cell sends a message it is recieved by its neighbors

Send(c) ==  /\ state.c.cs = Cardinality(NEIGHBORS.c) \* Check if the cell is blocked
            /\ state.c.t < MAXTIME \* Only send if the system has not reached max time
            /\ [state EXCEPT !.c.t = 1 + @, !.c.cs = state.c.ns, !.c.ns = 0]
            /\ \A n \in NEIGHBORS.c :
                    IF state.n.t = state.c.t + 1 THEN
                        [state EXCEPT !.n.cs = @ + 1]
                    ELSE [state EXCEPT !.n.ns = @ + 1] 
                   
GSNext == \E c \in CELLS : Send(c)                       
=============================================================================
\* Modification History
\* Last modified Tue Jan 09 11:23:14 GMT 2018 by affan
\* Created Mon Jan 08 11:40:06 GMT 2018 by affan
