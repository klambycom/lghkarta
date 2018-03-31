import React from "react";

const StreetImage = (props) => {
  const url = "https://maps.googleapis.com/maps/api/streetview";
  const params = `size=320x150&location=${props.latitude},${props.longitude}&pitch=5&source=outdoor`;

  return (
    <div>
      <img src={`${url}?${params}`} alt="Street view" />
    </div>
  );
};

export default StreetImage;
