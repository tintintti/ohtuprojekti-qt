set terminal png transparent size 640,240
set size 1.0,1.0

set terminal png transparent size 640,480
set output 'commits_by_author.png'
set key left top
set yrange [0:]
set xdata time
set timefmt "%s"
set format x "%Y-%m-%d"
set grid y
set ylabel "Commits"
set xtics rotate
set bmargin 6
plot 'commits_by_author.dat' using 1:2 title "Joerg Bornemann" w lines, 'commits_by_author.dat' using 1:3 title "Christian Kandeler" w lines, 'commits_by_author.dat' using 1:4 title "Jake Petroules" w lines, 'commits_by_author.dat' using 1:5 title "Tobias Hunger" w lines, 'commits_by_author.dat' using 1:6 title "Ruslan Nigmatullin" w lines, 'commits_by_author.dat' using 1:7 title "Orgad Shaneh" w lines, 'commits_by_author.dat' using 1:8 title "Marco Bubke" w lines, 'commits_by_author.dat' using 1:9 title "Yuchen Deng" w lines, 'commits_by_author.dat' using 1:10 title "Fawzi Mohamed" w lines, 'commits_by_author.dat' using 1:11 title "Leena Miettinen" w lines, 'commits_by_author.dat' using 1:12 title "Oswald Buddenhagen" w lines, 'commits_by_author.dat' using 1:13 title "Kai Koehne" w lines, 'commits_by_author.dat' using 1:14 title "Ray Donnelly" w lines, 'commits_by_author.dat' using 1:15 title "Aleksey Sidorov" w lines, 'commits_by_author.dat' using 1:16 title "hjk" w lines, 'commits_by_author.dat' using 1:17 title "Ilya Lyubimov" w lines, 'commits_by_author.dat' using 1:18 title "Marcel Krems" w lines, 'commits_by_author.dat' using 1:19 title "Tim Sander" w lines, 'commits_by_author.dat' using 1:20 title "Maxim Zaitsev" w lines, 'commits_by_author.dat' using 1:21 title "Ivan Komissarov" w lines
