---- MODULE MC ----
EXTENDS Izhikevich, TLC

\* CONSTANT definitions @modelParameterConstants:0InNeighbours
const_152176325278951000 == 
<< {6}, {1}, {2}, {3}, {4}, {5} >>
----

\* CONSTANT definitions @modelParameterConstants:1Neurons
const_152176325278952000 == 
6
----

\* CONSTANT definitions @modelParameterConstants:2OutNeighbours
const_152176325278953000 == 
<< {2}, {3}, {4}, {5}, {6}, {1} >>
----

\* CONSTANT definitions @modelParameterConstants:3MaxTime
const_152176325278954000 == 
5
----

\* CONSTANT definitions @modelParameterConstants:4MaxMsgMem
const_152176325278955000 == 
3
----

\* INIT definition @modelBehaviorInit:0
init_152176325278956000 ==
IzInit
----
\* NEXT definition @modelBehaviorNext:0
next_152176325278957000 ==
IzNext
----
=============================================================================
\* Modification History
\* Created Fri Mar 23 00:00:52 UTC 2018 by affan
