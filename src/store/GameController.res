let addDocumentEventListener: (
  string,
  ReactEvent.Keyboard.t => unit,
) => unit = %raw(`(event, handler) => document.addEventListener(event, handler)`)

let removeDocumentEventListener: (
  string,
  ReactEvent.Keyboard.t => unit,
) => unit = %raw(`(event, handler) => document.removeEventListener(event, handler)`)

let useInterval = (callback, timeout) => {
  let savedCallback = React.useRef(callback)

  React.useEffect1(() => {
    savedCallback.current = callback
    None
  }, [callback])

  React.useEffect1(() => {
    let timer = Js.Global.setInterval(() => savedCallback.current(), timeout)

    Some(() => Js.Global.clearInterval(timer))
  }, [timeout])

}

@react.component
let make = () => {
  open Store

  let { state, dispatch } = React.useContext(StoreContext.context)

  let onKeyDown = React.useCallback1(evt => {
    let key = ReactEvent.Keyboard.key(evt)

    switch key {
    | "ArrowLeft" => dispatch(MoveLeft)
    | "ArrowRight" => dispatch(MoveRight)
    | "ArrowUp" => dispatch(Rotate)
    | "ArrowDown" => dispatch(Drop)
    | _ => ()
    }
  }, [dispatch])

  React.useEffect1(() => {
    addDocumentEventListener("keydown", onKeyDown)

    Some(() => removeDocumentEventListener("keydown", onKeyDown))
  }, [onKeyDown])

  let timeOut = React.useMemo1(() => CoreLogic.getLevelTimeout(state.level), [state.level])

  useInterval(() => dispatch(Tick), timeOut)

  //timeOut -> React.int
  React.null
}
