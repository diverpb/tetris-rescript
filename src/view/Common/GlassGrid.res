@react.component
let make = (~glass) => {
  open Belt
  let rowStyle = ReactDOM.Style.make(~display="flex", ())

  let getCell = (indX, cell) => <GlassCell key={indX->Int.toString} cell />

  let getRow = (indX, column) =>
    <div key={indX->Int.toString} style={rowStyle}>
      {column->Array.mapWithIndex(getCell)->React.array}
    </div>

  <> {glass->Array.mapWithIndex(getRow)->React.array} </>
}
