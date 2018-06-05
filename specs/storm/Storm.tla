---- MODULE Storm ----

EXTENDS TLC, Naturals, FiniteSets, Sequences

VARIABLES Nodes,
          WideEdges,
          NarrowEdge,
          Root,
          State,
          PreviousStates

SInit ==  /\ Nodes = 4
          /\ WideEdges = << {2,3},{1,4},{2,4},{1,3} >>
          /\ NarrowEdge = <<{4},{3},{1},{2}>>
          /\ Root = 3
          /\ State = 
              [ n \in 1..Nodes |-> [credits |-> 0, totalcredits |-> 0] ]
          /\ PreviousStates = <<>>

\* RootInit == /\ State[Root].credits = 0
\*             /\  LET perDevice == 
\*                   CHOOSE c \in 1..1024:
\*                     /\ \E n \in 0..10: c = 2^n 
\*                     /\ c * Cardinality(WideEdges[Root]) < 1024
\*                     /\ \A j \in 1..1024:
\*                         /\ \E n \in 0..10: j = 2^n 
\*                         /\ c * Cardinality(WideEdges[Root]) < 1024
\*                         => c >= j
\*                 IN State' = [n \in 1..Nodes |->
\*                   IF n = Root THEN 
\*                     [ credits |-> 1, totalcredits |-> 
\*                         1 + perDevice * Cardinality(WideEdges[Root])
\*                     ]
\*                   ELSE IF n \in WideEdges[Root] THEN
\*                     [ credits |-> State[c].credits + perDevice
\*                       totalcredits |-> 0
\*                     ]
\*                   ELSE State[n]
\*                 ]

SendWide(n) ==  \/  /\  n = Root
                    /\  State[n].credits = 0
                    /\  LET perDevice == 
                          CHOOSE c \in 1..1024:
                            /\ \E m \in 0..10: c = 2^m 
                            /\ c * Cardinality(WideEdges[n]) < 1024
                            /\ \A j \in 1..1024:
                                /\ \E m \in 0..10: j = 2^m 
                                /\ j * Cardinality(WideEdges[n]) < 1024
                                => c >= j
                        IN State' = [i \in 1..Nodes |->
                          IF i = n THEN 
                            [ credits |-> 1, totalcredits |-> 
                                1 + perDevice * Cardinality(WideEdges[i])
                            ]
                          ELSE IF i \in WideEdges[n] THEN
                            [ credits |-> State[i].credits + perDevice,
                              totalcredits |-> State[i].totalcredits
                            ]
                          ELSE State[n]
                        ]
                    /\  PreviousStates' = Append(PreviousStates, State)
                    /\  UNCHANGED <<Nodes, WideEdges, NarrowEdge, Root>>
                \/  /\  n # Root
                    /\  State[n].credits >= Cardinality(WideEdges[n])
                    \* /\  LET perDevice == CHOOSE c \in 1..State[n].credits:
                    \*       /\ \E m \in 0..10: c = 2^m
                    \*       /\ c * 2 * Cardinality(WideEdges[n]) <= State[n].credits
                    \*       /\ \A j \in 1..State[n].credits:
                    \*           /\ \E m \in 0..10: j = 2^m
                    \*           /\ j * 2 * Cardinality(WideEdges[n]) <= State[n].credits
                    \*           => c >= j
                    /\  LET perDevice == CHOOSE c \in 1..State[n].credits:
                          /\ \E m \in 0..10: c = 2^m
                          /\ c * Cardinality(WideEdges[n]) <= State[n].credits
                          /\ \A j \in 1..State[n].credits:
                              /\ \E m \in 0..10: j = 2^m
                              /\ j * Cardinality(WideEdges[n]) <= State[n].credits
                              => c >= j
                        IN State' = [ i \in 1..Nodes |->
                          IF i = n THEN
                            [ credits |-> State[n].credits - perDevice*Cardinality(WideEdges[i]),
                              totalcredits |-> State[i].totalcredits]
                          ELSE IF i \in WideEdges[n] THEN
                            [ credits |-> State[i].credits + perDevice,
                              totalcredits |-> State[i].totalcredits ]
                          ELSE State[i]
                        ]
                    /\  PreviousStates' = Append(PreviousStates, State)
                    /\  UNCHANGED <<Nodes, WideEdges, NarrowEdge, Root>>

SendNarrow(n) ==  /\  n # Root
                  /\  State[n].credits > 0
                  /\  LET msgCredits == (State[n].credits + 1) \div 2
                      IN State' = [ i \in 1..Nodes |->
                        IF i = n THEN 
                          [ credits |-> State[n].credits - msgCredits,
                            totalcredits |-> State[i].totalcredits]
                        ELSE IF i \in NarrowEdge[n] THEN
                          [ credits |-> State[i].credits + msgCredits,
                            totalcredits |-> State[i].totalcredits ]
                        ELSE State[i]
                      ]
                  /\  PreviousStates' = Append(PreviousStates, State)
                  /\  UNCHANGED <<Nodes, WideEdges, NarrowEdge, Root>>

\* ReleaseCredits(n) ==  
\*       /\ State[n].credits > 0
\*       /\ n # Root
\*       /\  \/  /\ State[n].credits < Cardinality(WideEdges[n])
\*               /\  LET msgCredits == (State[n].credits + 1) \div 2
\*                   IN State' = [ i \in 1..Nodes |->
\*                     IF n = i THEN 
\*                       [ credits = State[n].credits - msgCredits,
\*                         totalcredits |-> 0]
\*                     ELSE IF i \in WideEdges[n] THEN
\*                       [ credits = State[i].credits + msgCredits,
\*                         totalcredits |-> 0 ]
\*                     ELSE State[i]
\*                   ]

SNext ==  \E n \in 1..Nodes : \/ SendWide(n)
                              \/ SendNarrow(n)

SSpec == SInit /\ [][SNext]_<<State, Nodes, WideEdges, NarrowEdge, Root>>

NoLoop == \A i \in 1..Len(PreviousStates): 
              \A j \in 1..Len(PreviousStates):
                IF i /= j THEN
                  PreviousStates[i] /= PreviousStates[j]
                ELSE TRUE
=============================================================================