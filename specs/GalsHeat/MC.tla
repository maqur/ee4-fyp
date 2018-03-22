---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1518180121778120000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_1518180121778121000 == 
<<{2},{1,3}, {2,4}, {3,5}, {4}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_1518180121778122000 == 
5
----

\* INIT definition @modelBehaviorInit:0
init_1518180121778123000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1518180121778124000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1518180121778125000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Fri Feb 09 12:42:01 UTC 2018 by affan
