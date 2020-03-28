runall: runFFT runDijkstra runHeap

runFFT: fft/FFTSample
	@echo "Running FFT sample:"
	@fft/FFTSample
runDijkstra: dijkstra/dijkstraSample
	@echo "\n\nRunning dijkstra sample"
	@dijkstra/dijkstraSample
runHeap: heap/heapSample
	@echo "\n\nRunning heap sample"
	@heap/heapSample

fft/FFTSample: fft/fft.chpl fft/example/poly.chpl
	chpl fft/fft.chpl fft/example/poly.chpl --main-module poly -o $@
dijkstra/dijkstraSample: heap/heap.chpl dijkstra/dijkstra.chpl dijkstra/example/cities.chpl
	chpl heap/heap.chpl dijkstra/dijkstra.chpl dijkstra/example/cities.chpl --main-module cities -o $@
heap/heapSample: heap/heap.chpl heap/example/heapsort.chpl
	chpl heap/heap.chpl heap/example/heapsort.chpl --main-module heapsort -o $@

clean:
	rm fft/FFTSample
	rm dijkstra/dijkstraSample
	rm heap/heapSample
