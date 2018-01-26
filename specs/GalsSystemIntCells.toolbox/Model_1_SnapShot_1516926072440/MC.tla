---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_1516926070423137000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_1516926070423138000 == 
<<{2},{1}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_1516926070423139000 == 
2
----

\* INIT definition @modelBehaviorInit:0
init_1516926070423140000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_1516926070423141000 ==
GSNext
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1516926070423142000 ==
TypeOK
----
=============================================================================
\* Modification History
\* Created Fri Jan 26 00:21:10 UTC 2018 by affan
