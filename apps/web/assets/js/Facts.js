import React from "react";
import formatter from "./formatter";

const Facts = (props) => {
  return (
    <ul className="Facts">
      <li>Hyra {formatter.rent(props.rent)}</li>
      <li>{props.rooms} rum</li>
      <li>{props.area} m²</li>
      <li>{props.landlord}</li>
      <li>{props.urban_area}</li>
    </ul>
  );
};

export default Facts;
