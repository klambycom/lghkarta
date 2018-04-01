import React from "react";
import formatter from "./formatter";

const Facts = (props) => {
  return (
    <ul className="Facts">
      <li>Hyra {formatter.rent(props.rent)}</li>
      <li>{props.rooms} rum</li>
      <li>{props.area}m2</li>
      <li>{props.landlord}</li>
      <li>{props.urban_area}</li>
    </ul>
  );
};

//{
//  "rooms": "3",
//  "area": "61",
//  "landlord": "Lifra",
//  "urban_area": "Norra Sofielund",
//  "available_date": "2018-05-01 00:00:00+02:00 +02 Etc/GMT-2",
//  "apply_before": "2018-03-27 23:59:00+02:00 +02 Etc/GMT-2"
//}

export default Facts;
