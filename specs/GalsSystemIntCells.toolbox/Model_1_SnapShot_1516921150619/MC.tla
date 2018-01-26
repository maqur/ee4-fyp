---- MODULE MC ----
EXTENDS GalsSystemIntCells, TLC

\* CONSTANT definitions @modelParameterConstants:0MAXTIME
const_151692114959884000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:1NEIGHBOURS
const_151692114959885000 == 
<<{2,3},{1}, {}>>
----

\* CONSTANT definitions @modelParameterConstants:2CELLS
const_151692114959886000 == 
3
----

\* INIT definition @modelBehaviorInit:0
init_151692114959887000 ==
GSInit
----
\* NEXT definition @modelBehaviorNext:0
next_151692114959888000 ==
GSNext
----
=============================================================================
\* Modification History
\* Created Thu Jan 25 22:59:09 UTC 2018 by affan
