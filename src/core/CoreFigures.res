open CoreTypes
open Belt

let parseFigure = arr => {
  arr
  ->Array.reduceWithIndex(list{}, (acc, arr, y) => {
    let ls = arr->Array.reduceWithIndex(list{}, (acc, elem, x) => List.add(acc, (elem, (x, y))))
    List.concat(acc, ls)
  })
  ->List.keep(i =>
    switch i {
    | (1, _) => true
    | (_, _) => false
    }
  )
  ->List.map(((_, (x, y))) => (x - 1, y - 1))
  ->List.toArray
}

let figure1 = [
    [0, 1, 0], 
    [1, 1, 1], 
]->parseFigure

let figure2 = [
    [0, 1, 1], 
    [1, 1, 0], 
]->parseFigure

let figure3 = [
    [1, 1, 0], 
    [0, 1, 1],
]->parseFigure

let figure4 = [
    [1, 1], 
    [1, 1],
]->parseFigure

let figure5 = [
    [0, 0, 0, 0],
    [1, 1, 1, 1],
]->parseFigure

let figure6 = [
    [1, 0, 0], 
    [1, 1, 1], 
]->parseFigure

let figure7 = [
    [0, 0, 1], 
    [1, 1, 1], 
]->parseFigure

module Figure = {
  type t = {
    color: color,
    cells: array<coord>,
  }

  let make = num => {
    let (color, cells) = switch num {
    | 1 => (Red, figure1)
    | 2 => (Green, figure2)
    | 3 => (Blue, figure3)
    | 4 => (Yellow, figure4)
    | 5 => (Cyan, figure5)
    | 6 => (Magenta, figure6)
    | _ => (Orange, figure7)
    }

    {color: color, cells: cells}
  }

  let rotate90 = ((x, y)) => (-y, x)

  let rotate = figure => {
    {
      ...figure,
      cells: figure.cells->Array.map(rotate90),
    }
  }

  let getCellCoords = (figure, position) => {
    let (px, py) = position
    figure.cells->Array.map(((x, y)) => (x + px, y + py))
  }
}
