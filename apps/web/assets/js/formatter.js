import settings from "./settings";

const formatter = {
  rent(value, replace_max=true) {
    if (replace_max && value === settings.rent.MAX) {
      return "Ingen gräns";
    }

    const value_with_spaces = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");

    return `${value_with_spaces} kr`;
  },

  rooms(values) {
    if (values.length === 0 || values.length === settings.rooms.LENGTH) {
      return "1-8, eller fler";
    }

    // Group values
    let result = values
      .reduce((acc, x) => {
        if (acc.previous - x < -1) {
          acc.parts.push([x]);
        }
        else {
          acc.parts[acc.parts.length - 1].push(x);
        }

        return {parts: acc.parts, previous: x};
      }, {parts: [[]], previous: 0})

    // Convert parts to string
    let text = result
      .parts
      .filter(x => x.length > 0)
      .map(x => {
        if (x.length === 1) { return x[0]; }
        return `${x[0]}-${x[x.length - 1]}`;
      })
      .join(", ");

    if (values[values.length - 1] === settings.rooms.MAX) {
      text += ", eller fler";
    }

    return text;
  },

  type(value) {
    if (!settings.TYPES[value]) { return value; }
    return settings.TYPES[value];
  },

  types(types, separator = ", ") {
    return types.map(x => settings.TYPES[x]).join(separator)
  }
};

export default formatter;
