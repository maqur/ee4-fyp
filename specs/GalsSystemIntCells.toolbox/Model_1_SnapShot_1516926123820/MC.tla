---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1516926121798149000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_1516926121798150000 == 
<<{2,3},{3,1}, {1,2}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_1516926121798151000 == 
3
----

\* INIT definition @modelBehaviorInit:0
init_1516926121798152000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1516926121798153000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1516926121799154000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Fri Jan 26 00:22:01 UTC 2018 by affan
