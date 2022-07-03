type cell =
  | Empty
  | Filled(CoreTypes.color)

let isEmpty = cell =>
  switch cell {
  | Empty => true
  | Filled(_) => false
  }

let empty = _ => Empty