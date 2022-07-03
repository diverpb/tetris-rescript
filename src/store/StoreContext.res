
open Store

type context = {
    state: state,
    dispatch: action => ()
}

let initialState = getInitialState()

let context = React.createContext({
    state: initialState,
    dispatch: _ => ()
})

@react.component 
let make = (~children) => {
    let provider = context -> React.Context.provider

    let (state, dispatch) = React.useReducer(reducer, initialState)
 
    React.createElement(provider, { "children": children, "value": { state, dispatch } })
}