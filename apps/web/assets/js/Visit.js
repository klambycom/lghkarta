import React from "react";

const Visit = (props) => {
  return (
    <a href={props.url} target="_blank" className="Visit">
      <p>Besök annonsen</p>
      <small>{props.url}</small>
    </a>
  );
};

export default Visit;
