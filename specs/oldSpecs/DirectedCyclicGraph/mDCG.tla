---- MODULE mDCG ----                                                             

EXTENDS DirectedCyclicGraph, TLC                                                         
                                                                                
NODES == 4                                                                        

IN_NEIGHBOURS == << {2,3}, {3,4}, {4,1}, {1,2}>>                                       

OUT_NEIGHBOURS == << {3,4}, {4,1}, {1,2}, {2,3} >>                             

MAX_TIME == 10                                                                  

init == DCGInit                                                                          
                                                                                
next == DCGNext                                                                          
                                                                                
============================================================================== 

