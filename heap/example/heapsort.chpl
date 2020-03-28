use Heap;
var D: domain(1) = {0..#6};
var arr: [D] int = [6, 1, 3, 6 ,9, 3];
var sorted: [D] int;

writeln("Sorting the array ", arr, " using heap sort.");

var pq: Heap = new Heap(int);
for e in arr {
  pq.push(e);
}

var idx: int = 0;

while pq.size() {
  sorted[idx] = pq.pop();
  idx += 1;
}
writeln("The newly sorted array is ", sorted);
