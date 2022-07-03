let commonStyle = ReactDOM.Style.make(~color="#eee")

let regular = commonStyle(~fontSize="1.2rem", ~paddingBottom="1rem", ())

let title = commonStyle(~fontSize="2rem", ~paddingTop="1rem", ~paddingBottom="2rem", ())

type size = Title | Regular

@react.component
let make = (~children, ~size=Regular) => {
  let style = switch size {
  | Title => title
  | Regular => regular
  }

  <div style> {children->React.string} </div>
}
