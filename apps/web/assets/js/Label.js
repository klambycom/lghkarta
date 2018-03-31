import React from "react";

const Label = (props) => {
  let valueTxt = props.value;
  if (props.formatter) {
    valueTxt = props.formatter(props.value);
  }

  return (
    <div className="Label">
      <span>{props.label}</span>
      <span className="value">{valueTxt}</span>
    </div>
  );
}

export default Label;
