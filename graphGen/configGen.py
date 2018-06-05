import numpy as np
import graphGen 

def InNeighbours(graph):
    string = '<< '
    for i in range(np.size(graph,1)):
        s = '{'
        for j in range(np.size(graph,0)):
            if graph[j][i] == 1:
                if s == '{':
                    s = s + str(j + 1)
                else:
                    s = s + ', ' + str(j + 1)
        
        if i == np.size(graph,1) - 1:
            string = string + s + '} >>'
        else:
            string = string + s + '}, '
    
    return string

def OutNeighbours(graph):
    string = '<< '
    for i in range(np.size(graph,0)):
        s = '{'
        for j in range(np.size(graph,1)):
            if graph[i][j] == 1:
                if s == '{':
                    s = s + str(j + 1)
                else:
                    s = s + ', ' + str(j + 1)
        
        if i == np.size(graph,1) - 1:
            string = string + s + '} >>'
        else:
            string = string + s + '}, '

    return string

if __name__ == "__main__":

    
    nodes = 6
    graphs = graphGen.GenRandomGraphs(nodes,2,0.01)
    inNeigh0 = InNeighbours(graphs[0])
    outNeigh0 = OutNeighbours(graphs[0])

    # file = open(filename, 'w')
    # for line in file:
    #     if 'IN_NEIGHBOURS' in line:
    #         line = 'IN_NEIGHBOURS == ' + inNeigh0
    #     elif 'OUT_NEIGHBOURS' in line:
    #         line = 'OUT_NEIGHBOURS == ' + outNeigh0
    #     elif 'NODES' in line:
    #         line = 'NODES == ' + nodes

    print(graphs[0])
    print(inNeigh0)
    print(outNeigh0)

