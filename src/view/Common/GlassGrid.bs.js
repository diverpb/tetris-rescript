// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as GlassCell$TetrisRescript from "./GlassCell.bs.js";

function GlassGrid(Props) {
  var glass = Props.glass;
  var rowStyle = {
    display: "flex"
  };
  var getCell = function (indX, cell) {
    return React.createElement(GlassCell$TetrisRescript.make, {
                cell: cell,
                key: String(indX)
              });
  };
  var getRow = function (indX, column) {
    return React.createElement("div", {
                key: String(indX),
                style: rowStyle
              }, Belt_Array.mapWithIndex(column, getCell));
  };
  return React.createElement(React.Fragment, undefined, Belt_Array.mapWithIndex(glass, getRow));
}

var make = GlassGrid;

export {
  make ,
  
}
/* react Not a pure module */
