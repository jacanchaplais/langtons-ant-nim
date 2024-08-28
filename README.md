# Langton's Ant in Nim

This program just outputs a simulation of Langton's ant, on a 100x100 grid, with the ant initialised at the centre pointing up.
The simulation terminates when the ant hits the wall of the grid.

It writes the output to a plaintext file called `grid-data.txt`, where each line is a row of the grid formatted as CSV, with values either `true` or `false`. Blank lines indicate that we've moved forward a timestep, and the grid data following is updated.

I wrote this just to test out Nim, so it's not very feature complete, but here it is!
