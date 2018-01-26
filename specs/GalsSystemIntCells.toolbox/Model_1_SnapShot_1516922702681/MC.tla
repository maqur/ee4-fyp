---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_151692270166189000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_151692270166190000 == 
<<{2,3},{1}, {}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_151692270166191000 == 
3
----

\* INIT definition @modelBehaviorInit:0
init_151692270166192000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_151692270166193000 ==
GSNext
----
=============================================================================
\* Modification History
\* Created Thu Jan 25 23:25:01 UTC 2018 by affan
