import React from "react";
import {GoogleMap, withGoogleMap, withScriptjs} from "react-google-maps";
import Pin from "./Pin";

const Map = withScriptjs(withGoogleMap((props) => {
  const position = {lat: 55.604981, lng: 13.003822};

  return (
    <GoogleMap defaultZoom={14} defaultCenter={position} options={{gestureHandling: 'cooperative'}}>
      {props.apartments.map(x => (
        <Pin
          id={x.id}
          latitude={+x.latitude}
          longitude={+x.longitude}
          title={x.title}
          url={x.url}
          facts={x.facts}
          onClick={props.onClick}
          isOpen={props.selectedId === x.id}
          key={x.id}
        />
      ))}
    </GoogleMap>
  );
}));

export default Map;
