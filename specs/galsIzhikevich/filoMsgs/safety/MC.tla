---- MODULE MC ----

EXTENDS GalsIzhikevich, TLC

NODES == 5

IN_NEIGHBOURS == << {3}, {1, 4}, {2, 5}, {3}, {4} >>

OUT_NEIGHBOURS == << {2}, {3}, {1, 4}, {2, 5}, {3} >>

MAX_TIME == 10

MAX_MEM == 3

ART_ERROR_T == 3

init == DCGInit

next == DCGNext

=============================================================================
