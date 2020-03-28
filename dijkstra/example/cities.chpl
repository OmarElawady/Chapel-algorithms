use Dijkstra;
use List;

var cities: domain(string) = {"Alex", "Cairo", "Fayoum", "Assiut", "Mansoura", "Minya", "Qena", "Aswan", "Luxor", "Sinai"};
var indices: [cities] int = [
"Alex"     => 1,
"Cairo"    => 2,
"Fayoum"    => 3,
"Assiut"   => 4,
"Mansoura" => 5,
"Minya"    => 6,
"Qena"     => 7,
"Aswan"   => 8,
"Luxor"    => 9,
"Sinai"    => 10
];

var reverse: [1..10] string = [
"Alex",
"Cairo",
"Fayoum",
"Assiut",
"Mansoura",
"Minya",
"Qena",
"Aswan",
"Luxor",
"Sinai"
];
var dik: Dijkstra = new Dijkstra(10);
dik.add_edge(indices["Alex"], indices["Mansoura"], 12);
dik.add_edge(indices["Cairo"], indices["Assiut"], 140);
dik.add_edge(indices["Cairo"], indices["Sinai"], 149);
dik.add_edge(indices["Fayoum"], indices["Minya"], 154);
dik.add_edge(indices["Fayoum"], indices["Qena"], 9);
dik.add_edge(indices["Fayoum"], indices["Aswan"], 226);
dik.add_edge(indices["Fayoum"], indices["Sinai"], 132);
dik.add_edge(indices["Assiut"], indices["Sinai"], 55);
dik.add_edge(indices["Mansoura"], indices["Aswan"], 33);
dik.add_edge(indices["Qena"], indices["Aswan"], 173);
try{
  var path: list(int);
  var cost: int;
  writeln("""In the map
         154              226             33                 12
Minya --------- Fayoum --------- Aswan --------- Mansoura --------- Alex
                  |  \           /
                  |   \         /
             132  |    \ 9     /  173
                  |     \     /
                  |      \   /
                Sinai     Qena
                 / \
                /   \
           55  /     \  149
              /       \
             /         \
           Assiut --- Cairo
                  140""");

  (path, cost) = (dik.shortest_path(indices["Alex"], indices["Sinai"]));
  writeln("The shortest path  from Alex to Sinai has a cost ", cost, " and is as follows:");
  for e in path {
    writeln(reverse[e]);
  }
} catch {
  writeln("Oops! an error occured.");
}

