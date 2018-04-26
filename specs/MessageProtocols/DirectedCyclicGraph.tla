---- MODULE DirectedCyclicGraph ----

EXTENDS     FiniteSets, Integers, Sequences, RandomOrderMessages

CONSTANTS   Nodes,
            InNeighbours,
            OutNeighbours,
            MaxTime

VARIABLE    state

DCGInit ==  /\  MsgInit
            /\  state = [ n \in 1..Nodes |-> [                                
                    t |-> 0,                                                    
                    c |-> [m \in 0..MaxTime |->                               
                        IF m = 0 THEN Cardinality(InNeighbours[n]) ELSE 0       
                    ]                                                          
                ]]                                                              

-----------------------------------------------------------------------------

Fire(n) ==  /\  state[n].t < MaxTime                                             
            /\  state[n].c[state[n].t] = Cardinality(InNeighbours[n])                     
            /\  LET msg == 
                    {[  sender |-> n,
                        out |-> o,
                        t |-> state[n].t + 1
                    ] : o \in OutNeighbours[n]}
                IN SendMsg(msg)
            /\ state' = [ state EXCEPT ![n].t = state[n].t + 1 ]                     
                                                                                
Receive(m)  ==  /\  GetMsg(m)
                /\  state' = [ state EXCEPT ![m.out].c[m.t] = 1 + @ ]

DCGNext ==  \/ \E n \in 1..Nodes : Fire(n)                                    
            \/ \E m \in messages : Receive(m)  

-----------------------------------------------------------------------------

NeighbourOK ==  \A n \in 1..Nodes :                                           
                    /\ \A i \in InNeighbours[n] : n \in OutNeighbours[i]        
                    /\ \A o \in OutNeighbours[n] : n \in InNeighbours[o]

TypeOK  ==  /\  \A n \in 1..Nodes :                                           
                    /\ state[n].t <= MaxTime                                    
                    /\ \A m \in 1..Nodes:                                   
                            state[n].c[m] <= Cardinality(InNeighbours[n])

=============================================================================


