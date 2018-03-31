import React from "react";

const MultiSelect = (props) => {
  const options = props.rooms.map(x => {
    x.selected = props.selected.includes(x.value);
    return x;
  });

  return (
    <div className="MultiSelect">
      <div className="label">{props.label}</div>
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
