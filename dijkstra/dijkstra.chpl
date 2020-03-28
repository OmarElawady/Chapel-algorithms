module Dijkstra {
use List;
use Heap;
param INF = 1000000000;

class Dijkstra{
  var nodes: int;
  var adjacency_list: list;
  proc init(nodes: int) {
    this.nodes = nodes;
    adjacency_list = new list(list(2 * int));
    for i in 1..nodes do adjacency_list.append(new list(2 * int));
  }

  proc add_edge(source: int, destination: int, cost: int, directed: bool = false){
    adjacency_list[source].append((destination, cost));
    if !directed {
      adjacency_list[destination].append((source, cost));
    }
  }

  proc construct_path(parent_array, source, destination): list(int) {
    var current_node = destination;
    var path: list = new list(int);
    while current_node != source {
      path.append(current_node);
      current_node = parent_array[current_node];
    }
    path.append(source);
    for i in 1..#(path.size / 2) {
      path[i] <=> path[path.size - i + 1];
    }
    return path;
  }

  proc shortest_path(source: int, destination: int) : (list(int), int) throws {
    var pq: Heap = new Heap(2 * int); // weight, node
    var dist_array: [1..nodes] int;
    var parent_array: [1..nodes] int;
    for e in dist_array do e = INF;
    pq.push((0, source));
    dist_array[source] = 0;
    parent_array[source] = -1;
    while(pq.size()){
      var weight, node: int;
      (weight, node) = pq.pop();
      if weight != dist_array[node] then continue; // visited this node before
      if node == destination then return (construct_path(parent_array, source, destination), weight);

      for (neighbor, cost) in adjacency_list[node] {
        var total_cost = cost + weight;
        if total_cost < dist_array[neighbor] {
          dist_array[neighbor] = total_cost;
          parent_array[neighbor] = node;
          pq.push((total_cost, neighbor));
        }
      }
    }
    return (new list(int), -1);
  }
}
}
