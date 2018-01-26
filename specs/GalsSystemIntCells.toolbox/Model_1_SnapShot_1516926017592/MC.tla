---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1516926015566131000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_1516926015567132000 == 
<<{2},{1}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_1516926015567133000 == 
2
----

\* INIT definition @modelBehaviorInit:0
init_1516926015567134000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1516926015567135000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1516926015567136000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Fri Jan 26 00:20:15 UTC 2018 by affan
