import React from "react";

const months = [
  "januari",
  "februari",
  "mars",
  "april",
  "maj",
  "juni",
  "juli",
  "augusti",
  "september",
  "oktober",
  "november",
  "december"
];

const DateTime = (props) => {
  let formatted_date = props.format;
  formatted_date = formatted_date.replace("%d%", props.date.getDate());
  formatted_date = formatted_date.replace("%month%", months[props.date.getMonth()]);
  formatted_date = formatted_date.replace("%year%", props.date.getFullYear());
  formatted_date = formatted_date.replace("%hh%", `0${props.date.getHours()}`.slice(-2));
  formatted_date = formatted_date.replace("%mm%", `0${props.date.getMinutes()}`.slice(-2));

  return (<div className="DateTime">{formatted_date}</div>);
};

export default DateTime;
