module type GlassConfigType = {
  let height: int
  let width: int
}

module type GlassType = (Config: GlassConfigType) =>
{
  type t

  let make: unit => t
  let toArray: t => array<array<CoreCell.cell>>
  let removeFilledLines: t => (int, t)
  let canMergeToGlass: (t, array<CoreTypes.coord>) => bool
  let mergeToGlass: (t, array<CoreTypes.coord>, CoreCell.cell) => t
}

module Glass: GlassType = (Config: GlassConfigType) => {
  open Belt
  open CoreCell

  let toUnit = _ => ()

  type line = array<cell>

  type t = array<line>

  let makeLine = _ => Array.makeBy(Config.width, empty)

  let make = () => {
    Array.makeBy(Config.height, makeLine)
  }

  let toArray = glass => glass

  let copy = glass => glass->Array.map(Array.copy)

  let getCell = (glass, (x, y)) => {
    let column = glass->Array.get(y)
    switch column {
    | None => None
    | Some(column) => column->Array.get(x)
    }
  }

  let setCellImpure = (glass, x, y, elem) => {
    let column = glass->Array.get(y)
    switch column {
    | None => ()
    | Some(arr) => arr->Array.set(x, elem)->toUnit
    }
  }

  let removeFilledLines = prevGlass => {
    let hasEmpty = line => Array.some(line, isEmpty)

    let glass = prevGlass->Array.keep(hasEmpty)
    let removedLines = Config.height - Array.size(glass)

    (removedLines, Array.concat(Array.makeBy(removedLines, makeLine), glass))
  }

  let canMergeToGlass = (glass, cells) => {
    cells
    ->Array.map(getCell(glass))
    ->Array.every(elem =>
      switch elem {
      | None => false
      | Some(elem) => isEmpty(elem)
      }
    )
  }

  let mergeToGlass = (glass, cells, elem) => {
    let newGlass = copy(glass)

    Array.forEach(cells, ((x, y)) => setCellImpure(newGlass, x, y, elem))

    newGlass
  }
}
