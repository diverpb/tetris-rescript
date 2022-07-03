@react.component
let make = () => {
  open CoreLogic
  let {state} = React.useContext(StoreContext.context)

  let glass = switch state.mode {
  | Play => mergeFigure(state.glass, state.currentFigure, state.currentPosition)
  | _ => state.glass
  }->GameGlass.toArray

  <GameGlassContainer> <GlassGrid glass /> </GameGlassContainer>
}
