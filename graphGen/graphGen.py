import random

def genRandomGraphs(noOfNodes, noOfGraphs):

    graph = [[0 for x in range(noOfNodes)] for y in range(noOfNodes)]

    for i in range(noOfNodes-1):
        graph[i][i+1] = 1

    graph[noOfNodes-1][0] = 1

    print(graph)

    tmp = noOfNodes*noOfNodes - 2*noOfNodes
    extraEdges = int(random.triangular(0, tmp, tmp/5)) 

    for i in range(1,extraEdges+1):
        idx1 = random.randrange(noOfNodes)
        seq = []

        for j in range(noOfNodes):
            if j != idx1 and j != (idx1+1) % noOfNodes:
                seq.append(j)
        idx2 = random.choice(seq)

        graph[idx1][idx2] = 1

    return graph

def main():
    g = genRandomGraphs(4,1)
    print(g)

if __name__ == "__main__":
    main()
    