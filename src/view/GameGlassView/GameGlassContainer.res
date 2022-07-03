let containerStyle = ReactDOM.Style.make(
  ~border="4px solid gray",
  ~paddingLeft="4px",
  ~paddingTop="4px",
  ~borderTop="none",
  (),
)

@react.component
let make = (~children: React.element) => {
  <div style=containerStyle> children </div>
}
