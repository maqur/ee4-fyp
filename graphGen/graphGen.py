import numpy as np
import random

def GenRandomGraphs(noOfNodes, noOfGraphs, graphDensity):

    graphs = np.zeros((noOfGraphs, noOfNodes, noOfNodes), dtype=np.int8)

    for i in range(noOfNodes-1):
        graphs[:, i, i+1] = 1
    
    tmp = np.array([ 2**(-i) for i in range(1,noOfNodes)])
    probs = tmp / np.sum(tmp)
    cumProbs = np.cumsum(probs)

    for n in range(noOfGraphs):

        idx = np.digitize(random.random(), cumProbs)
        for i in range(0,idx+1):
            graphs[n, noOfNodes-i-1, idx-i] = 1

        emptyEdges = noOfNodes**2 - noOfNodes - idx + 1
        extraEdges = int(
            random.triangular(0, emptyEdges, emptyEdges*graphDensity)) 

        for i in range(extraEdges):

            x = random.randrange(noOfNodes)
            seq = []

            for j in range(noOfNodes):
                if j != x and j != (x-noOfNodes+idx+1) % noOfNodes:
                    seq.append(j)

            y = random.choice(seq)

            graphs[n, x, y] = 1

    return graphs

def main():
    g = GenRandomGraphs(6,1,0.01)
    print(g)

if __name__ == "__main__":
    main()
    