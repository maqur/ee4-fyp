----------------------------- MODULE Izhikevich -----------------------------

EXTENDS     FiniteSets, Integers, Sequences

CONSTANTS   Neurons,
            InNeighbours,
            OutNeighbours,
            MaxTime,
            MaxMsgMem

VARIABLES   state,
            messages

IzInit  ==  /\  state = [ n \in 1..Neurons |-> [   
                    t |-> 0, 
                    c |-> [m \in 1..MaxMsgMem |-> 
                        IF m = 1 THEN Cardinality(InNeighbours[n]) ELSE 0 
                    ],
                    \* time difference (ahead) from out nueron
                    tDiff |-> [o \in OutNeighbours[n] |-> 0]
                ]]
            /\  messages = {}

Fire(n) ==  /\ state[n].t < MaxTime
            /\ state[n].c[1] = Cardinality(InNeighbours[n])
            /\ \A o \in OutNeighbours[n]: state[n].tDiff[o] < MaxMsgMem - 1
            /\ messages' = messages \cup 
                \* send fire message to all OUT neurons
                {[  type |-> "fire", 
                    sender |-> n, 
                    out |-> o, 
                    t |-> state[n].t + 1
                ] : o \in OutNeighbours[n]} \cup
                \* send current time to IN neurons
                \* to limit messages to a particular time ahead
                {[  type |-> "confirm",
                    sender |-> n, 
                    out |-> i, 
                    t |-> state[n].t + 1
                ] : i \in InNeighbours[n]} 
            /\ state' = 
                [ state EXCEPT
                    ![n].t = state[n].t + 1,
                    ![n].c =    [ m \in 1..MaxMsgMem |->
                                IF m = MaxMsgMem THEN 0 ELSE @[m+1] 
                                ],
                    ![n].tDiff = 
                        [ o \in OutNeighbours[n] |-> 1 + @[o]]  
                ]

Receive(msg)    ==  \/  /\  msg.type = "fire"
                        /\  LET diff == msg.t - state[msg.out].t + 1
                            IN state' = 
                                [state EXCEPT ![msg.out].c[diff] = 1 + @ ]
                        /\  messages' = messages \ {msg}

                    \/  /\  msg.type = "confirm"
                        /\  LET diff == 
                                state[msg.out].t - msg.t
                            IN state' = [state EXCEPT 
                                ![msg.out].tDiff[msg.sender] = 
                                    IF diff < @ THEN diff ELSE @ 
                            ]
                        /\  messages' = messages \ {msg}

IzNext  ==  \/ \E n \in 1..Neurons : Fire(n)
            \/ \E m \in messages : Receive(m)

NeighbourOK ==  \A n \in 1..Neurons :                                           
                    /\ \A i \in InNeighbours[n] : n \in OutNeighbours[i]      
                    /\ \A o \in OutNeighbours[n] : n \in InNeighbours[o]      
                                                                                
TimeDiffOK  ==  \A n \in 1..Neurons :                                           
                    /\ \A i \in InNeighbours[n]:                               
                        state[i].t - state[n].t < MaxMsgMem                             
                    /\ \A o \in OutNeighbours[n]:
                        /\ state[n].tDiff[o] < MaxMsgMem
                        /\ state[n].t - state[o].t < MaxMsgMem
                    
                                                                                
TypeOK  ==  /\  \A n \in 1..Neurons :                                           
                    /\ state[n].t <= MaxTime                                    
                    /\ \A m \in 1..MaxMsgMem:                             
                            state[n].c[m] <= Cardinality(InNeighbours[n])      
                                                                                 
=============================================================================
\* Modification History
\* Last modified Fri Mar 23 11:53:54 UTC 2018 by affan
\* Created Thu Mar 08 18:39:43 UTC 2018 by affan
