---- MODULE Storm ----

EXTENDS TLC, Naturals, FiniteSets, Sequences

----

CONSTANTS Nodes,
          Root,
          NarrowEdge,
          WideEdges

VARIABLES state,
          previousStates

-----

SInit ==  /\ state =
              [ n \in 1..Nodes |-> [credits |-> 0, totalcredits |-> 0] ]
          /\ previousStates = <<>>

SendWide(n) ==
    \/  /\  n = Root
        /\  state[n].credits = 0
        /\  LET perDevice ==
              CHOOSE c \in 1..1024:
                /\ \E m \in 0..10: c = 2^m
                /\ c * Cardinality(WideEdges[n]) < 1024
                /\ \A j \in 1..1024:
                    /\ \E m \in 0..10: j = 2^m
                    /\ j * Cardinality(WideEdges[n]) < 1024
                    => c >= j
            IN state' = [i \in 1..Nodes |->
              IF i = n THEN
                [ credits |-> 1, totalcredits |->
                    1 + perDevice * Cardinality(WideEdges[i])
                ]
              ELSE IF i \in WideEdges[n] THEN
                [ credits |-> state[i].credits + perDevice,
                  totalcredits |-> state[i].totalcredits
                ]
              ELSE state[n]
            ]
        /\  previousStates' = Append(previousStates, state)
    \/  /\  n # Root
        /\  state[n].credits >= Cardinality(WideEdges[n])
        /\  LET perDevice == CHOOSE c \in 1..state[n].credits:
              /\ \E m \in 0..10: c = 2^m
              /\ c * Cardinality(WideEdges[n]) <= state[n].credits
              /\ \A j \in 1..state[n].credits:
                  /\ \E m \in 0..10: j = 2^m
                  /\ j * Cardinality(WideEdges[n]) <= state[n].credits
                  => c >= j
            IN state' = [ i \in 1..Nodes |->
              IF i = n THEN
                [ credits |->
                    state[n].credits - perDevice*Cardinality(WideEdges[i]),
                  totalcredits |-> state[i].totalcredits]
              ELSE IF i \in WideEdges[n] THEN
                [ credits |-> state[i].credits + perDevice,
                  totalcredits |-> state[i].totalcredits ]
              ELSE state[i]
            ]
        /\  previousStates' = Append(previousStates, state)

SendNarrow(n) ==  /\  n # Root
                  /\  state[n].credits > 0
                  /\  LET msgCredits == (state[n].credits + 1) \div 2
                      IN state' = [ i \in 1..Nodes |->
                        IF i = n THEN
                          [ credits |-> state[n].credits - msgCredits,
                            totalcredits |-> state[i].totalcredits]
                        ELSE IF i \in NarrowEdge[n] THEN
                          [ credits |-> state[i].credits + msgCredits,
                            totalcredits |-> state[i].totalcredits ]
                        ELSE state[i]
                      ]
                  /\  previousStates' = Append(previousStates, state)

SNext ==  \E n \in 1..Nodes : \/ SendWide(n)
                              \/ SendNarrow(n)

SSpec == SInit /\ [][SNext]_<<state, Nodes, WideEdges, NarrowEdge, Root>>

----

NoLoop == \A i \in 1..Len(previousStates):
              \A j \in 1..Len(previousStates):
                IF i /= j THEN
                  previousStates[i] /= previousStates[j]
                ELSE TRUE

=============================================================================