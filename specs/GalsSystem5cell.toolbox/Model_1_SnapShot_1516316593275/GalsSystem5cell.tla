-------------------------- MODULE GalsSystem5cell --------------------------
EXTENDS     Naturals, FiniteSets

CONSTANT    MAXTIME

VARIABLES   cells, 
            neighbours,
            state
            
(***************************************************************************)
(*                                     c1                                  *)
(*                                      |                                  *)
(*                                      |                                  *)
(*                             c2 ---- c5 ---- c4                          *)
(*                                      |                                  *)
(*                                      |                                  *)
(*                                     c3                                  *)
(***************************************************************************)
            
GSInit  ==  /\ cells = {"c1", "c2", "c3", "c4", "c5"} 
            /\ neighbours = [
                    c1:{"c5"}, c2:{"c5"}, c3:{"c5"}, 
                    c4:{"c5"}, c5:{"c1", "c2", "c3", "c4"}]
            /\ state = [
                    c1 |-> [t |-> 0, cs |-> 1, ns |-> 0],
                    c2 |-> [t |-> 0, cs |-> 1, ns |-> 0],
                    c3 |-> [t |-> 0, cs |-> 1, ns |-> 0],
                    c4 |-> [t |-> 0, cs |-> 1, ns |-> 0],
                    c5 |-> [t |-> 0, cs |-> 4, ns |-> 0]]
                    
nextC1  ==  /\ state.c1.cs = 1 \* Cardinality(neighbours.c1)
            /\ state.c1.t < MAXTIME
            \* /\ [state EXCEPT !.c1.t = 1+@, !.c1.cs = state.c1.ns, !.c1.ns = 0]
            /\ IF state.c5.t = state.c1.t + 1 
                    THEN state' = [state EXCEPT !.c1.t = 1+@, !.c1.cs = state.c1.ns, !.c1.ns = 0, !.c5.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c1.t = 1+@, !.c1.cs = state.c1.ns, !.c1.ns = 0, !.c5.ns = @ + 1]
            /\ UNCHANGED <<cells, neighbours>> 

nextC2  ==  /\ state.c2.cs = 1 \* Cardinality(neighbours.c2)
            /\ state.c2.t < MAXTIME
            \* /\ state' = [state EXCEPT !.c2.t = 1+@, !.c2.cs = state.c2.ns, !.c2.ns = 0]
            /\ IF state.c5.t = state.c2.t + 1 
                    THEN state' = [state EXCEPT !.c2.t = 1+@, !.c2.cs = state.c2.ns, !.c2.ns = 0, !.c5.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c2.t = 1+@, !.c2.cs = state.c2.ns, !.c2.ns = 0, !.c5.ns = @ + 1]
            /\ UNCHANGED <<cells, neighbours>> 

nextC3  ==  /\ state.c3.cs = 1 \* Cardinality(neighbours.c1)
            /\ state.c3.t < MAXTIME
            \* /\ [state EXCEPT !.c3.t = 1+@, !.c3.cs = state.c3.ns, !.c3.ns = 0]
            /\ IF state.c5.t = state.c3.t + 1 
                    THEN state' = [state EXCEPT !.c3.t = 1+@, !.c3.cs = state.c3.ns, !.c3.ns = 0, !.c5.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c3.t = 1+@, !.c3.cs = state.c3.ns, !.c3.ns = 0, !.c5.ns = @ + 1]
            /\ UNCHANGED <<cells, neighbours>> 

nextC4  ==  /\ state.c4.cs = 1 \* Cardinality(neighbours.c4)
            /\ state.c4.t < MAXTIME
            \* /\ [state EXCEPT !.c4.t = 1+@, !.c4.cs = state.c4.ns, !.c4.ns = 0]
            /\ IF state.c5.t = state.c4.t + 1 
                    THEN state' = [state EXCEPT !.c4.t = 1+@, !.c4.cs = state.c4.ns, !.c4.ns = 0, !.c5.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c4.t = 1+@, !.c4.cs = state.c4.ns, !.c4.ns = 0, !.c5.ns = @ + 1]
            /\ UNCHANGED <<cells, neighbours>> 

nextC5  ==  /\ state.c5.cs = 4 \* Cardinality(neighbours.c5)
            /\ state.c5.t < MAXTIME
            \* /\ [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0]
            /\ IF state.c1.t = state.c5.t + 1 
                    THEN state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c1.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c1.ns = @ + 1]
            /\ IF state.c2.t = state.c5.t + 1 
                    THEN state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c2.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c2.ns = @ + 1]
            /\ IF state.c3.t = state.c5.t + 1 
                    THEN state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c3.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c3.ns = @ + 1]
            /\ IF state.c4.t = state.c5.t + 1 
                    THEN state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c4.cs = @ + 1]
                    ELSE state' = [state EXCEPT !.c5.t = 1+@, !.c5.cs = state.c5.ns, !.c5.ns = 0, !.c4.ns = @ + 1]
            /\ UNCHANGED <<cells, neighbours>> 
            
GSNext  ==  \/ nextC1
            \/ nextC2
            \/ nextC3
            \/ nextC4
            \/ nextC5
            
GSSpec == GSInit /\ [][GSNext]_<<cells, neighbours, state>>  
=============================================================================
\* Modification History
\* Last modified Thu Jan 18 23:03:03 GMT 2018 by affan
\* Created Fri Jan 12 14:36:03 GMT 2018 by affan
