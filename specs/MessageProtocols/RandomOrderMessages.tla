---- MODULE RandomOrderMessages ----

VARIABLE    messages

MsgInit ==  messages = {}

SendMsg(m) ==   messages' = messages \cup m   

GetMsg(m) ==    messages' = messages \ {m}      


====
