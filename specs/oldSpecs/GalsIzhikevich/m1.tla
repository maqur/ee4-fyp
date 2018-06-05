---- MODULE m1 ----
EXTENDS Izhikevich, TLC

IN_NEIGHBOURS == 
<< {2,3}, {3,4}, {4,1}, {1,2}>>

NEURONS == 
4

OUT_NEIGHBOURS == 
<< {3,4}, {4,1}, {1,2}, {2,3} >>

MAX_TIME == 
5

init ==
IzInit

next ==
IzNext

===============================================================================
