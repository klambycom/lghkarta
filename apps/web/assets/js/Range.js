import React from "react";
import Label from "./Label";

const Range = (props) => {
  return (
    <div className="Range">
      <Label label={props.label} value={props.value} formatter={props.formatter} />
      <div>
        <input
          type="range"
          min={props.min}
          max={props.max}
          step={props.step}
          value={props.value}
          onChange={(e) => props.onChange(+e.target.value)}
        />
      </div>
    </div>
  );
}

export default Range;
