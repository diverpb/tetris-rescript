let leftColumnStyle = ReactDOM.Style.make(
  ~width="100%",
  ~display="flex",
  ~flexDirection="column",
  ~alignItems="center",
  (),
)

module GameOverInfo = {
  open Belt

  @react.component
  let make = (~totalScore: int, ~restart: unit => unit) => {
    <>
      <Text size=Text.Title> "Game over!" </Text>
      <Text> {`Your final score: ${totalScore->Int.toString}`} </Text>
      <br />
      <Button onClick=restart> "Restart" </Button>
    </>
  }
}

module IdleInfo = {
  @react.component
  let make = (~start: unit => unit) => {
    <> <Text> "Wanna play?" </Text> <Button onClick=start> "Lets goooo!" </Button> </>
  }
}

module PlayInfo = {
  module NextGlassConfig = {
    let width = 5
    let height = 2
  }

  module NextGlass = CoreGlass.Glass(NextGlassConfig)

  @react.component
  let make = (~level, ~score, ~nextFigure) => {
    open Belt

    let cells = CoreLogic.Figure.getCellCoords(nextFigure, (2, 1))
    let glass =
      NextGlass.make()
      ->NextGlass.mergeToGlass(cells, CoreCell.Filled(nextFigure.color))
      ->NextGlass.toArray

    <>
      <Text> {`Next Figure:`} </Text>
      <GlassGrid glass />
      <br />
      <Text> {`Level: ${level->Int.toString}`} </Text>
      <Text> {`Score: ${score->Int.toString}`} </Text>
    </>
  }
}

@react.component
let make = () => {
  open Store
  let {state, dispatch} = StoreContext.context->React.useContext

  <div style=leftColumnStyle>
    {switch state.mode {
    | Play => <PlayInfo score=state.score level=state.level nextFigure=state.nextFigure />
    | Idle => <IdleInfo start={() => dispatch(Start)} />
    | GameOver => <GameOverInfo totalScore=state.score restart={() => dispatch(Start)} />
    }}
  </div>
}
