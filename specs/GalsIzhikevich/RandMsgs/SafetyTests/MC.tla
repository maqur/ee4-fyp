---- MODULE MC ----

EXTENDS GalsIzhikevich, TLC

NODES == 6

IN_NEIGHBOURS == << {6}, {1,6}, {2,5}, {1,3}, {1,4}, {5}>>

OUT_NEIGHBOURS == << {2,4,5}, {3}, {4}, {5}, {3,6}, {1,2} >>

MAX_TIME == 15

MAX_MEM == 3

ART_ERROR_T == 5

init == DCGInit

next == DCGNext

inv ==  /\ NeighbourOK
        /\ TypeOK
        /\ TimeDiffOK
        /\ ArtificialError

==============================================================================
