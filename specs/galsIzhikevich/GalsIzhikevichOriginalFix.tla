--------------------------- MODULE GalsIzhikevichOriginalFix ----------------

EXTENDS FiniteSets, Integers

-----

CONSTANTS   Neurons, \* Total number of neurons
            \*A tuple representing the set of in neighbours of each neuron
            InNeighbours,
            \*A tuple representing the set of out neighbours of each neuron
            OutNeighbours,
            MaxTime

(***************************************************************************)
(* The state variable is a function with domain the set of neurons         *)
(* and range a record with fieds: t (current time of neuron),              *)
(* p (number of pending fires), c (count of recieved messages)             *)
(***************************************************************************)
VARIABLES   state

----

(*********)
(*Initialize the state of each neuron with t = 0, having 1 pending fire *)
(*(p = 1) and not having received any messages (c = 0) *)
(*********)
GIInit  ==  state = [ n \in 1..Neurons |->
                        [   t |-> 0,
                            c |-> [t \in 0..MaxTime |->
                                IF t = 0 THEN Cardinality(InNeighbours[n])
                                ELSE 0]
                        ]
                    ]

Next(n) ==  /\ state[n].t < MaxTime
            /\ state[n].c[state[n].t] = Cardinality(InNeighbours[n])
            /\ state' =
                [ a \in 1..Neurons |->
                    IF a = n THEN
                        [ state[n] EXCEPT !.t = 1 + @ ]
                    ELSE IF a \in OutNeighbours[n] THEN
                        [ state[a] EXCEPT !.c[state[n].t + 1] = 1 + @ ]
                    ELSE
                        state[a]
                ]

GINext  ==  \E n \in 1..Neurons : Next(n)

GISpec  ==  GIInit /\ [][GINext]_<<state>>

-----

\*Check that the connections are correct
NeighbourOK ==  \A n \in 1..Neurons :
                    /\ \A i \in InNeighbours[n] : n \in OutNeighbours[i]
                    /\ \A o \in OutNeighbours[n] : n \in InNeighbours[o]

(*Check that the out neighbour is not more then 1 timestep ahead, need to *)
(* receive the message of current time step before jumping the next one *)
TimeDiffOK  ==  \A n \in 1..Neurons :
                    /\ \A i \in InNeighbours[n]:
                        /\ state[n].t - state[i].t < 2
                    /\ \A o \in OutNeighbours[n]:
                        /\ state[n].t - state[o].t > -2

\*Check that the values of the state variables are correct
TypeOK  ==  /\  \A n \in 1..Neurons :
                    /\ state[n].t <= MaxTime
                    /\ \A t \in 0..MaxTime :
                        state[n].c[t] <= Cardinality(InNeighbours[n])

=============================================================================
