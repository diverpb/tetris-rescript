let rootStyle = ReactDOM.Style.make(
  ~width="100vw",
  ~height="100vh",
  ~overflow="hidden",
  ~color="#eee",
  ~backgroundColor="#111",
  ~display="flex",
  ~flexDirection="column",
  ~alignItems="center",
  ()
)

let twoColumnContainerStyle = ReactDOM.Style.make(~display="flex", ())

let leftColumnStyle = ReactDOM.Style.make(~width="25vw", ())

@react.component
let make = () => {
  <StoreContext>
    <div style=rootStyle>
      <GameController />
      <Title />
      <div style=twoColumnContainerStyle>
        <div style=leftColumnStyle> 
          <GameInfo /> 
        </div>
        <div> 
          <GameGlassView /> 
        </div> 
      </div>
    </div>
  </StoreContext>
}
