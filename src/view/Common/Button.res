let style = ReactDOM.Style.make(
  ~background="transparent",
  ~border="2px solid green",
  ~color="green",
  ~fontSize="1.5rem",
  ~padding="1rem 2rem",
  ~cursor="pointer",
  ()
)

@react.component
let make = (~children, ~onClick) => {
  <button style onClick={_ => onClick()}> {children->React.string} </button>
}
