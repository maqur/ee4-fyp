---- MODULE MC ----

EXTENDS GalsIzhikevich, TLC

NODES == 4

IN_NEIGHBOURS == << {2,3}, {3,4}, {4,1}, {1,2}>>

OUT_NEIGHBOURS == << {3,4}, {4,1}, {1,2}, {2,3} >>

MAX_TIME == 3

MAX_MEM == 2

init == DCGInit

next == DCGNext

inv ==  /\ NeighbourOK
        /\ TypeOK
        /\ TimeDiffOK

=============================================================================
