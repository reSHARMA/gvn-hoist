set datafile separator ','
set key box left
set key spacing 1
#set logscale y 2
set term postscript dashed color
set output "printme.ps"
#plot "ex.csv" using 1:3:xtic(2) with points title "old SCoP detection"
set margin 10
set xtics rotate by 55 right
set style data points
#set title "GCM stats"

#plot 'gvn-stat.csv' using 2:xticlabels(1) with points title "total hoisted", \
#     'gvn-stat.csv' using 3:xticlabels(1) with points title "total removed",\
#     'gvn-stat.csv' using 4:xticlabels(1) with points title "scalars hoisted",\
#     'gvn-stat.csv' using 5:xticlabels(1) with points title "scalars removed",\
#     'gvn-stat.csv' using 6:xticlabels(1) with points title "loads hoisted",\
#     'gvn-stat.csv' using 7:xticlabels(1) with points title "loads removed",\
#     'gvn-stat.csv' using 8:xticlabels(1) with points title "stores hoisted=removed",\
#     'gvn-stat.csv' using 9:xticlabels(1) with points title "calls hoisted=removed",\
#     'gvn-stat.csv' using 7:xticlabels(1) with points title "instructions sunk"
#

plot 'gvn-stat.csv' using ($3 < 1 ? $3 : log10($3)/log10(2)+1):xticlabels(1) ps 1.5 title "scalars hoisted",\
     'gvn-stat.csv' using ($4 < 1 ? $4 : log10($4)/log10(2)+1):xticlabels(1) ps 1.5 title "loads hoisted",\
     'gvn-stat.csv' using ($5 < 1 ? $5 : log10($5)/log10(2)+1):xticlabels(1) ps 1.5 title "stores hoisted",\
     'gvn-stat.csv' using ($6 < 1 ? $6 : log10($6)/log10(2)+1):xticlabels(1) ps 1.5 title "calls hoisted",\
     'gvn-stat.csv' using ($7 < 1 ? $7 : log10($7)/log10(2)+1):xticlabels(1) ps 1.5 title "instructions sunk"

#plot 'ex.csv' u 2:3:1 w labels offset 1
