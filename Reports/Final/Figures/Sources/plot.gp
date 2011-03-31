set term postscript eps enhanced color

set title "Percentage coverage of Greedy vs Hybrid for set 1"
set xlabel "Graph Instance"
set ylabel "Percentage Coverage"
set output "Hybrid1.eps" 

plot "tgfGreedyRes.data" using 1:12 title "Algorithm 1" with linespoints, \
"tgfGreedyRes.data" using 1:13 title "Algorithm 2" with linespoints, \
"tgfGreedyRes.data" using 1:14 title "Algorithm 3" with linespoints, \
"tgfGreedyRes.data" using 1:15 title "Algorithm 4" with linespoints, \
"resultsHybrid1.data" using 1:4 title "Hybrid" with linespoints;

set title "Percentage coverage of Greedy vs Hybrid for set 2"
set output "Hybrid2.eps"
unset ylabel

plot "greedyKeGraphRes.data" using 1:12 title "Algorithm 1" with linespoints, \
"greedyKeGraphRes.data" using 1:13 title "Algorithm 2" with linespoints, \
"greedyKeGraphRes.data" using 1:14 title "Algorithm 3" with linespoints, \
"greedyKeGraphRes.data" using 1:15 title "Algorithm 4" with linespoints, \
"resultsHybrid2.data" using 1:4 title "Hybrid" with linespoints;


