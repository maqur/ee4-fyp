---- MODULE GalsIzhikevich ----

EXTENDS     FiniteSets, Integers, Sequences, RandMessages

CONSTANTS   Nodes,
            InNeighbours,
            OutNeighbours,
            MaxTime,
            MaxMem

VARIABLE    state,
            messages

DCGInit ==  /\  messages = InitMsg
            /\  state = [ n \in 1..Nodes |-> [
                    t |-> 0,
                    c |-> [m \in 1..MaxMem |->
                        IF m = 1 THEN Cardinality(InNeighbours[n]) ELSE 0
                    ],
                    \* time difference (ahead) from out nueron
                    tDiff |-> [o \in OutNeighbours[n] |-> 0]
                ]]

-----------------------------------------------------------------------------

Fire(n) ==  /\  state[n].t < MaxTime
            /\  state[n].c[1] = Cardinality(InNeighbours[n])
            /\ \A o \in OutNeighbours[n]: state[n].tDiff[o] < MaxMem - 1
            /\  LET msg ==
                    {[  type |-> "fire",
                        sender |-> n,
                        out |-> o,
                        t |-> state[n].t + 1
                    ] : o \in OutNeighbours[n]} \cup
                    \* send current time to IN nodes
                    \* to limit messages to a particular time ahead
                    {[  type |-> "confirm",
                        sender |-> n,
                        out |-> i,
                        t |-> state[n].t + 1
                    ] : i \in InNeighbours[n]}
                    IN messages' = SendMsg(messages, msg)
            /\ state' =
                [ state EXCEPT
                    ![n].t = state[n].t + 1,
                    ![n].c =    [ m \in 1..MaxMem |->
                                IF m = MaxMem THEN 0 ELSE @[m+1]
                                ],
                    ![n].tDiff =
                          [ o \in OutNeighbours[n] |-> 1 + @[o]]
                ]

Receive(m) ==   \/  /\  m.type = "fire"
                    /\  messages' = RemoveMsg(messages, m)
                    /\  LET diff == m.t - state[m.out].t + 1
                            IN state' =
                                [state EXCEPT ![m.out].c[diff] = 1 + @ ]

                \/  /\  m.type = "confirm"
                    /\  messages' = RemoveMsg(messages, m)
                    /\  LET diff ==
                            state[m.out].t - m.t
                        IN state' = [state EXCEPT
                            ![m.out].tDiff[m.sender] =
                                IF diff < @ THEN diff ELSE @
                        ]

DCGNext ==  \/  \E n \in 1..Nodes : Fire(n)
            \/  /\ MsgAvailable(messages)
                /\ \E m \in GetMsg(messages) : Receive(m)

-----------------------------------------------------------------------------

NeighbourOK ==  \A n \in 1..Nodes :
                    /\ \A i \in InNeighbours[n] : n \in OutNeighbours[i]
                    /\ \A o \in OutNeighbours[n] : n \in InNeighbours[o]

TypeOK  ==  /\  \A n \in 1..Nodes :
                    /\ state[n].t <= MaxTime
                    /\ \A m \in 1..MaxMem:
                            state[n].c[m] <= Cardinality(InNeighbours[n])

TimeDiffOK  ==  \A n \in 1..Nodes :
                    /\ \A i \in InNeighbours[n]:
                        state[i].t - state[n].t < MaxMem
                    /\ \A o \in OutNeighbours[n]:
                        /\ state[n].tDiff[o] < MaxMem
                        /\ state[n].t - state[o].t < MaxMem


=============================================================================
