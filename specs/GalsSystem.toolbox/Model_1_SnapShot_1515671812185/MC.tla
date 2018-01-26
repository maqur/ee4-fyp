---- MODULE MC ----
EXTENDS GalsSystem, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
c1, c2
----

\* MV CONSTANT definitions CELLS
const_1515671810146159000 == 
{c1, c2}
----

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1515671810146160000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:2NEIGHBOURS
const_1515671810146161000 == 
[c1:{c2}, c2:{c1}]
----

\* INIT definition @modelBehaviorInit:0
init_1515671810146162000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1515671810146163000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1515671810146164000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Thu Jan 11 11:56:50 GMT 2018 by affan
