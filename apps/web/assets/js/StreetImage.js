import React from "react";
import settings from "./settings";

const StreetImage = (props) => {
  const url = "https://maps.googleapis.com/maps/api/streetview";
  const params = `size=320x150&location=${props.latitude},${props.longitude}&pitch=5&source=outdoor`;

  return (
    <div>
      <img src={`${url}?${params}&key=${settings.google_maps.KEY}`} alt="Street View Image" />
    </div>
  );
};

export default StreetImage;
