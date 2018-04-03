import React from "react";
import formatter from "./formatter";
import Icon from "./Icon";

const handleClick = (event, item, props) => {
  props.onClick(item);
  event.preventDefault();
};

const History = (props) => {
  if (props.items.length === 0) { return null; }

  return (
    <div className="History">
      <h3>Dina tidigare sökningar</h3>
      {props.items.map((x, i) => (
        <span key={i}>
          <Icon type="history" />
          {" "}
          <a href="#" onClick={e => handleClick(e, x, props)}>
            Maxhyra: {formatter.rent(x.rent)}; Antal rum: {formatter.rooms(x.rooms)}; {formatter.types(x.types || [], "; ")}
          </a>
        </span>
      ))}
    </div>
  );
};

export default History;
