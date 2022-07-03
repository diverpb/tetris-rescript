let maxLevel = 10
let maxTimeout = 1000
let minTimeout = 100

module GameGlassConfig = {
  let width = 10
  let height = 20
}

module GameGlass = CoreGlass.Glass(GameGlassConfig)
module Figure = CoreFigures.Figure

let mergeFigure = (glass, figure, position) => {
  let cells = Figure.getCellCoords(figure, position)

  GameGlass.mergeToGlass(glass, cells, CoreCell.Filled(figure.color))
}

let canPlaceFigure = (glass, figure, position) =>
  figure->Figure.getCellCoords(position)->GameGlass.canMergeToGlass(glass, _)

let movePostion = ((x, y), (ox, oy)) => (x + ox, y + oy)

let moveFigure = (glass, figure, position, offset) => {
  let nextPosition = movePostion(position, offset)

  canPlaceFigure(glass, figure, nextPosition) ? Some(nextPosition) : None
}

let rotateFigure = (glass, figure, position) => {
  let rotated = Figure.rotate(figure)

  canPlaceFigure(glass, rotated, position) ? Some(rotated) : None
}

let landFigure = (glass, figure, position) =>
  mergeFigure(glass, figure, position)->GameGlass.removeFilledLines

let scoreIncrement = removedLines =>
  switch removedLines {
  | 4 => 1000
  | 3 => 700
  | 2 => 400
  | 1 => 100
  | _ => 0
  }

let getLevel = score => (score / 1000 + 1)->Js.Math.min_int(maxLevel)

let getLevelTimeout = level => {
  open Belt.Int
  open Belt.Float

  let minLevel = 1.
  let maxLevel = maxLevel->toFloat
  let maxTimeoutLog = maxTimeout->toFloat->Js.Math.log
  let minTimeoutLog = minTimeout->toFloat->Js.Math.log

  let scale = (maxTimeoutLog -. minTimeoutLog) /. (maxLevel -. minLevel)

  (maxTimeoutLog -. scale *. (toFloat(level) -. minLevel))->Js.Math.exp->toInt
}
