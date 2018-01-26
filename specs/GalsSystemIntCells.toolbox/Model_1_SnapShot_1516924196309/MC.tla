---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_151692419428094000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_151692419428095000 == 
<<{2,3},{1}, {}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_151692419428096000 == 
3
----

\* INIT definition @modelBehaviorInit:0
init_151692419428097000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_151692419428098000 ==
GSNext
----
=============================================================================
\* Modification History
\* Created Thu Jan 25 23:49:54 UTC 2018 by affan
