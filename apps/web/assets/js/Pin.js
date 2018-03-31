import React from "react";
import {Marker, InfoWindow} from "react-google-maps";
import Visit from "./Visit";
import Facts from "./Facts";
import StreetImage from "./StreetImage";

const Pin = (props) => {
  return (
    <Marker position={{lat: props.latitude, lng: props.longitude}} onClick={x => props.onClick(props, x)}>
      {props.isOpen && <InfoWindow>
        <div className="Pin-popup">
          <h3>{props.title}</h3>
          <Facts
            rooms={props.facts.rooms}
            area={props.facts.area}
            landlord={props.facts.landlord}
            urban_area={props.facts.urban_area}
          />
          <StreetImage latitude={props.latitude} longitude={props.longitude} />
          <Visit url={props.url} />
        </div>
      </InfoWindow>}
    </Marker>
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

export default Pin;
