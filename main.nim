import strformat
import times

from algorithm import fill
from math import floorDiv

const
  NUM_ROWS = 1_000
  NUM_COLS = 1_000

type
  Direction = enum
    UP, RIGHT, DOWN, LEFT

  Ant = object
    x: range[0 .. NUM_COLS]
    y: range[0 .. NUM_ROWS]
    alive: bool = true
    direction: Direction

  Grid = array[NUM_ROWS, array[NUM_COLS, bool]]

proc move(ant: var Ant, grid: var Grid) =
  let
    x = ant.x
    y = ant.y
  if (x == 0) or (x == NUM_COLS) or (y == 0) or (y == NUM_ROWS):
    ant.alive = false
    return
  let cell = grid[y][x]
  if cell:
    ant.direction =
      if ant.direction != LEFT:
        ant.direction.succ
      else: # cycle to beginning
        UP
  else:
    ant.direction =
      if ant.direction != UP:
        ant.direction.pred
      else: # go to end
        LEFT
  grid[y][x] = not cell
  case ant.direction
  of RIGHT:
    ant.x += 1
  of DOWN:
    ant.y += 1
  of LEFT:
    ant.x -= 1
  of UP:
    ant.y -= 1

proc main() =
  let start = cpuTime()
  var ant = Ant(
    x: floorDiv(NUM_COLS, 2),
    y: floorDiv(NUM_ROWS, 2),
    direction: UP
  )
  var grid: Grid
  for row_idx in 0 ..< len(grid):
    grid[row_idx].fill(false)

  var out_file = open("ant-data.txt", fmWrite)
  defer:
    close(out_file)

  while ant.alive:
    out_file.write(&"{ant.y},{ant.x}\n")
    move(ant, grid)

  echo("time: ", cpuTime() - start)

main()
