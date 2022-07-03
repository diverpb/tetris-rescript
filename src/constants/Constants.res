let getColorString = color => {
  open CoreTypes
  switch color {
  | Red => "#b33"
  | Green => "#3b3"
  | Blue => "#33b"
  | Yellow => "#bb3"
  | Cyan => "#3bb"
  | Magenta => "#b3b"
  | Orange => "#b83"
  | Grey => "#333"
  }
}

let startPosition = (4, 1)

let leftOffset = (-1, 0)

let rightOffset = (1, 0)

let downOffset = (0, 1)
