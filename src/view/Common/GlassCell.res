let getStyle = color =>
  ReactDOM.Style.make(
    ~backgroundColor=color,
    ~width="30px",
    ~height="30px",
    ~marginRight="3px",
    ~marginBottom="3px",
    (),
  )

@react.component
let make = (~cell) => {
  open Constants
  open CoreCell
  open CoreTypes

  switch cell {
  | Empty => <div style={Grey->getColorString->getStyle} />
  | Filled(color) => <div style={color->getColorString->getStyle} />
  }
}
