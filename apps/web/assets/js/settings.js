const ROOM_VALUES = [
  {value: 1, text: "1"},
  {value: 2, text: "2"},
  {value: 3, text: "3"},
  {value: 4, text: "4"},
  {value: 5, text: "5"},
  {value: 6, text: "6"},
  {value: 7, text: "7"},
  {value: 8, text: "8+"}
];

const settings = {
  rent: {
    MAX: 20000,
    MIN: 1000,
    STEP: 500
  },

  rooms: {
    MAX: ROOM_VALUES[ROOM_VALUES.length - 1].value,
    LENGTH: ROOM_VALUES.length,
    VALUES: ROOM_VALUES
  },

  google_maps: {
    JS: "https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places",
    KEY: "AIzaSyDtTZTBMSoEnrum5YU9JszzbX-y6MemEWs"
  },

  TYPES: {
    apartment: "Lägenhet",
    short_term: "Korttidskontrakt",
    senior: "Seniorboende",
    new_construction: "Nybyggt",
    older_tenant: "Trygghetsboende",
    youth_apartment: "Ungdomslägenhet",
    student_housing: "Studentbostad"
  }
};

export default settings;
