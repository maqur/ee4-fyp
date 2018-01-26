---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1516925960956125000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_1516925960956126000 == 
<<{2},{1}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_1516925960956127000 == 
2
----

\* INIT definition @modelBehaviorInit:0
init_1516925960956128000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1516925960956129000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1516925960956130000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Fri Jan 26 00:19:20 UTC 2018 by affan
