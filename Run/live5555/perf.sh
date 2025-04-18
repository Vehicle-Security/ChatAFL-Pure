
if [ ! -d ~/FlameGraph ]; then
	cd ~
	git clone https://github.com/brendangregg/FlameGraph.git
fi

perf script > out.perf
~/FlameGraph/stackcollapse-perf.pl out.perf > out.folded
~/FlameGraph/flamegraph.pl out.folded > flamegraph.svg
