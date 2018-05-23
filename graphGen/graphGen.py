import numpy as np
import random

def getCycleIdx(noOfNodes):

    tmp = np.array([ 2**(-i) for i in range(1,noOfNodes)])
    s = np.sum(tmp)
    probs = tmp / s
    cumProbs = np.cumsum(probs)
    rand = random.random()
    idx = np.digitize(rand, cumProbs)

    return idx

def genRandomGraphs(noOfNodes, noOfGraphs, graphSparcity):

    graph = [[0 for x in range(noOfNodes)] for y in range(noOfNodes)]

    for i in range(noOfNodes-1):
        graph[i][i+1] = 1

    idx = getCycleIdx(noOfNodes)

    for i in range(0,idx+1):
        graph[noOfNodes - 1 - i][idx - i] = 1

    print(graph)
    tmp = noOfNodes**2 - noOfNodes - idx + 1
    extraEdges = int(random.triangular(0, tmp, tmp*graphSparcity)) 

    for i in range(1,extraEdges+1):
        idx1 = random.randrange(noOfNodes)
        seq = []

        for j in range(noOfNodes):
            if j != idx1 and j != (idx1-noOfNodes+idx+1) % noOfNodes:
                seq.append(j)
        idx2 = random.choice(seq)

        graph[idx1][idx2] = 1

    return graph

def main():
    g = genRandomGraphs(6,1,0.01)
    print(g)

if __name__ == "__main__":
    main()
    