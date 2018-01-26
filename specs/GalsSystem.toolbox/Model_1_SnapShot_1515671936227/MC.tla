---- MODULE MC ----
EXTENDS GalsSystem, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
c1, c2
----

\* MV CONSTANT definitions CELLS
const_1515671934208171000 == 
{c1, c2}
----

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1515671934208172000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:2NEIGHBOURS
const_1515671934208173000 == 
[c1:{c2}, c2:{c1}]
----

\* INIT definition @modelBehaviorInit:0
init_1515671934208174000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1515671934208175000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1515671934208176000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Thu Jan 11 11:58:54 GMT 2018 by affan
