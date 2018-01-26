---- MODULE MC ----
EXTENDS GalsSystem, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
c1, c2
----

\* MV CONSTANT definitions CELLS
const_1515681299522195000 == 
{c1, c2}
----

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1515681299522196000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:2NEIGHBOURS
const_1515681299522197000 == 
{[c1:{c2}, c2:{c1}]}
----

\* INIT definition @modelBehaviorInit:0
init_1515681299522198000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1515681299522199000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1515681299522200000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Thu Jan 11 14:34:59 GMT 2018 by affan
