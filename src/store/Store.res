open CoreTypes
open CoreLogic

type mode = Idle | Play | GameOver

type state = {
  glass: GameGlass.t,
  currentPosition: coord,
  currentFigure: Figure.t,
  nextFigure: Figure.t,
  mode: mode,
  level: int,
  score: int,
}

let getRandomFigure = () => Figure.make(Js.Math.random_int(1, 8))

let getInitialState = () => {
  glass: GameGlass.make(),
  currentPosition: Constants.startPosition,
  currentFigure: getRandomFigure(),
  nextFigure: getRandomFigure(),
  mode: Idle,
  level: 1,
  score: 0,
}

type action = Tick | Start | MoveLeft | MoveRight | Rotate | Drop

let startGame = _ => {
  ...getInitialState(),
  mode: Play,
}

let move = (offset, state) =>
  switch moveFigure(state.glass, state.currentFigure, state.currentPosition, offset) {
  | Some(nextPosition) => {...state, currentPosition: nextPosition}
  | None => state
  }

let moveLeft = move(Constants.leftOffset)
let moveRight = move(Constants.rightOffset)

let rotate = state =>
  switch rotateFigure(state.glass, state.currentFigure, state.currentPosition) {
  | Some(rotated) => {...state, currentFigure: rotated}
  | None => state
  }

let land = (state, position) => {
  let (removedLinesCount, glass) = landFigure(state.glass, state.currentFigure, position)
  let score = state.score + scoreIncrement(removedLinesCount)
  let level = getLevel(score)

  if canPlaceFigure(glass, state.nextFigure, Constants.startPosition) {
    let currentFigure = state.nextFigure
    let nextFigure = getRandomFigure()
    {
      ...state,
      glass: glass,
      currentFigure: currentFigure,
      nextFigure: nextFigure,
      score: score,
      level: level,
      currentPosition: Constants.startPosition,
    }
  } else {
    {...state, glass: glass, score: score, mode: GameOver}
  }
}

let moveDown = (glass, figure, position) => moveFigure(glass, figure, position, Constants.downOffset)

let tick = state => {
  switch moveDown(state.glass, state.currentFigure, state.currentPosition) {
  | None => land(state, state.currentPosition)
  | Some(nextPosition) => {...state, currentPosition: nextPosition}
  }
}

let drop = state => {
  let rec moveDownRec = position =>
    switch moveDown(state.glass, state.currentFigure, position) {
    | None => position
    | Some(nextPosition) => moveDownRec(nextPosition)
    }

  land(state, moveDownRec(state.currentPosition))
}

let id = a => a

let reducer = (state, action) =>
  state->switch (state.mode, action) {
  | (Idle | GameOver, Start) => startGame
  | (Play, Tick) => tick
  | (Play, MoveLeft) => moveLeft
  | (Play, MoveRight) => moveRight
  | (Play, Rotate) => rotate
  | (Play, Drop) => drop
  | (_, _) => id
  }
