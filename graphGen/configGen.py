import numpy as np
import graphGen
import argparse

def InNeighbours(graph):
    """
    serialize the graph as a string object and return the in neighbours for the graph
    :param graph: an array indicating the graph object
    :return: string object representation for the graph
    """
    string = '<< '
    for i in range(np.size(graph, 1)):
        s = '{'
        for j in range(np.size(graph, 0)):
            if graph[j][i] == 1:
                if s == '{':
                    s = s + str(j + 1)
                else:
                    s = s + ', ' + str(j + 1)

        if i == np.size(graph, 1) - 1:
            string = string + s + '} >>'
        else:
            string = string + s + '}, '
    return string


def OutNeighbours(graph):
    """
    serialize the graph as a string object and return the out neighbours for the graph
    :param graph: this is an array indicating the graph object
    :return: string representation for the graph
    """
    string = '<< '
    for i in range(np.size(graph, 0)):
        s = '{'
        for j in range(np.size(graph, 1)):
            if graph[i][j] == 1:
                if s == '{':
                    s = s + str(j + 1)
                else:
                    s = s + ', ' + str(j + 1)

        if i == np.size(graph, 1) - 1:
            string = string + s + '} >>'
        else:
            string = string + s + '}, '

    return string


def main():
    """tool to determine the in neighbours and out neighbours for the graph"""
    parser = argparse.ArgumentParser(
        description='Script to generates strings use to define in and out \
        neighbours in a configuration file')

    parser.add_argument('--number_of_nodes', '-n', default=6,
                        help='Specify the number of nodes for the graph',
                        action='store')

    parser.add_argument('--number_of_graphs', '-g', default=1,
                        help='Specify the number of graphs',
                        action='store')

    parser.add_argument('--density', '-d', default=0.1,
                        help='number of extra edges added randomly with continuous triangular distribution or with peak \
                            at density, value should be between 0 and 1',
                        action='store')

    cli_args = parser.parse_args()
    number_of_nodes = int(cli_args.number_of_nodes)
    number_of_graphs = int(cli_args.number_of_graphs)
    density = float(cli_args.density)
    graphs = graphGen.GenRandomGraphs(number_of_nodes, number_of_graphs, density)
    inNeigh0 = InNeighbours(graphs[0])
    outNeigh0 = OutNeighbours(graphs[0])
    print(graphs[0])
    print(inNeigh0)
    print(outNeigh0)

if __name__ == "__main__":
    main()