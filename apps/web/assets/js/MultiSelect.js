import React from "react";
import Label from "./Label";

const MultiSelect = (props) => {
  const options = props.options.map(x => {
    x.selected = props.selected.includes(x.value);
    return x;
  });

  return (
    <div className="MultiSelect">
      <Label label={props.label} value={props.selected} formatter={props.formatter} />
      <div className="buttons">
        {options.map((x, i) => (
          <button
            value={x.value}
            onClick={() => {
              options[i].selected = !options[i].selected;
              props.onChange(options.filter(y => y.selected).map(y => y.value));
            }}
            key={x.value}
            className={x.selected ? "selected" : ""}
          >{x.text}</button>
        ))}
      </div>
    </div>
  );
}

export default MultiSelect;
