# Plot status.csv
# Usage: gnuplot ../bin/plot-status.gp

# Set the terminal type to png, you can change it to your preferred
# terminal type
#set term x11 size 1000, 400
set terminal pngcairo enhanced font 'Arial,10' fontscale 1.0 size 1000, 500
set output '/tmp/bruce/book/output.png'

# Set the title and labels
set title "Graph status.csv"
set xlabel "Date"
set ylabel "Pages"

# Set the x-axis to be time and specify the time format
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"

# Ensure gnuplot reads the data correctly and handles missing data
set datafile separator ","
set datafile missing "NaN"

# Rotate the x-axis labels to make them more readable
set xtics rotate by -45

# Set grid for better visualization
set grid


# Specify the CSV file to read and the columns to use
plot './status.csv' using 1:2 with lines title 'Pages over Time' lw 5
