

//  main.swift
//  pageRank_Two

import Foundation

print("Program to impliment PageRank In Swift")
print("***************************************");

public class Vertex {
    var key: String?
    var rank: Double
    var neighbors: Array<Edge>
    init() {
        self.neighbors = Array<Edge>()
        rank = 0;
    }
}

public class Edge {
    var neighbor: Vertex
    var weight: Int
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}

class Path {
    var total: Int!
    var destination: Vertex
    var previous: Path!
    
    //object initialization
    init(){ destination = Vertex() }
}

public class SwiftGraph {
    private var canvas: Array<Vertex>
    public var isDirected: Bool
    init() {
        canvas = Array<Vertex>()
        isDirected = true
    }
    //create a new vertex
    func addVertex(key: String) -> Vertex {
        //set the key
        let childVertex: Vertex = Vertex()
        childVertex.key = key
        //add the vertex to the graph canvas
        canvas.append(childVertex)
        return childVertex
    }
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        //create a new edge
        let newEdge = Edge()
        //establish the default properties
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        //check for undirected graph
        if (isDirected == false) {
            //create a new reversed edge
            let reverseEdge = Edge()
            //establish the reversed properties
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
        }
    }
    /**
     * calPageRankVertices(),function This calculates the page rank of various vertices using the formula described here:
     *  https://en.wikipedia.org/wiki/PageRank#Damping_factor
     *	First counts the vertices and returns the value,
     *	Then initializes all the vertices to the same page rank (1/N where N is the number of vertices),
     *	Then loops through the vertices X times, calculating their page rank and
     *	damping factor(d)= 0.85
     *  PR(A)=(1-d)/N + d (PR(B)/L(B) + PR(C)/L(C) + ........)
     *
     *Then prints the values out.
     ***/
    func calPageRankVertices(){
        //Node node, Edge [] edges,
        
        let d = 0.85;
        let N:Double = Double(canvas.count);
        for (v) in canvas{
            v.rank = 1/N;
        }
        
        print("Number Of Vertices: ", N);
        print("*************************");
        for(var i=0;i<20;i++){
            for (v) in canvas{
                var inbound: Double = 0;
                for (v2) in canvas{
                    let m:Double = Double(v2.neighbors.count);
                    for (e) in v2.neighbors{
                        if(e.neighbor === v){
                            inbound += v2.rank / m;
                        }
                    }
                }
                v.rank =  (1 - d) / N + d*inbound;
            }
        }
        print("Rank of Vertices ");
        print("******************");
        for (v) in canvas{
            print(v.key, v.rank);
        }
    }    
}// end graph

//class instaces 
var graph = SwiftGraph()
//add vertex
var a = graph.addVertex("a")
//.......
//.......
// add edges with equal eques of one
graph.addEdge(a, neighbor: b, weight: 1)
//....
//....
// call calPageRankVertices 
graph.calPageRankVertices()
