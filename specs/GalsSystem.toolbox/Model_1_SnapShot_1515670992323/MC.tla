---- MODULE MC ----
EXTENDS GalsSystem, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
c1, c2
----

\* MV CONSTANT definitions CELLS
const_1515670990280135000 == 
{c1, c2}
----

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1515670990280136000 == 
3
----

\* CONSTANT definitions @modelParameterConstants:2NEIGHBOURS
const_1515670990280137000 == 
[c1:{c2}, c2:{c1}]
----

\* INIT definition @modelBehaviorInit:0
init_1515670990280138000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1515670990280139000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1515670990280140000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Thu Jan 11 11:43:10 GMT 2018 by affan
