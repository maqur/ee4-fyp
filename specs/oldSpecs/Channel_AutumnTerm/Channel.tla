------------------------------ MODULE Channel ------------------------------
CONSTANT Message
VARIABLE chan

Inner(q) == INSTANCE InnerChannel

Spec == \EE q : Inner(q)!Spec

=============================================================================
\* Modification History
\* Last modified Mon Nov 13 00:43:18 GMT 2017 by affan
\* Created Mon Nov 13 00:37:12 GMT 2017 by affan
