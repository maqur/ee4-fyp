import numpy as np
import random
import argparse

def GenRandomGraphs(noOfNodes, noOfGraphs, graphDensity):
    """
    generates a random strongly connected digraph
    :param noOfNodes: the number of nodes for the graph
    :param noOfGraphs: the number of graphs
    :param graphDensity: number of extra edges added randomly with continious \
                        triangular distribution with peak \
                        at density, value should be between 0 and 1
    :return: array of randomly generated graphs
    """
    graphs = np.zeros((noOfGraphs, noOfNodes, noOfNodes), dtype=np.int8)

    for i in range(noOfNodes-1):
        graphs[:, i, i+1] = 1

    tmp = np.array([2**-i for i in range(1, noOfNodes)])
    probs = tmp / np.sum(tmp)
    cumProbs = np.cumsum(probs)

    for n in range(noOfGraphs):

        idx = np.digitize(random.random(), cumProbs)
        for i in range(0, idx+1):
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


def main(noOfNodes=6, noOfGraphs=1, density=0.1):
    g = GenRandomGraphs(noOfNodes,noOfGraphs,density)
    print(g)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Script to generate random graphs')

    parser.add_argument('--number_of_nodes', '-n', default=6,
                        help='Specify the number of nodes for the graph',
                        action='store')

    parser.add_argument('--number_of_graphs', '-g', default=1,
                        help='Specify the number of graphs',
                        action='store')

    parser.add_argument('--density', '-d', default=0.1,
                        help='number of extra edges added randomly with \
                        continious triangular distribution or with peak \
                        at density, value should be between 0 and 1',
                        action='store')

    cli_args = parser.parse_args()
    number_of_nodes = int(cli_args.number_of_nodes)
    number_of_graphs = int(cli_args.number_of_graphs)
    density = float(cli_args.density)
    main(number_of_nodes, number_of_graphs, density)