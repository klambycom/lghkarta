import React, {Component} from "react";
import MultiSelect from "./MultiSelect";
import Range from "./Range";

const MAX_RENT = 20000;
const MAX_ROOMS = 8;

const check = {
  rooms(nr_of_rooms, selected) {
    if (selected.length === 0) { return true; }

    // Check if the apartment have the selected amount of rooms or more than max
    // if that is selected.
    return (selected.includes(MAX_ROOMS) && nr_of_rooms > MAX_ROOMS) || selected.includes(nr_of_rooms);
  }
};

const formatter = {
  rent(value, max_value) {
    if (max_value && value === max_value) {
      return "Ingen gräns";
    }

    return `${value} kr`;
  }
}

class Filter extends Component {
  constructor(props) {
    super(props);

    this.state = {
      rent: MAX_RENT,
      rooms: []
    };
  }

  render() {
    const apartments = this.props.apartments
      .filter(x => check.rooms(+x.facts.rooms, this.state.rooms));

    return (
      <div className="Filter">
        <h2>Filtrera</h2>
        <Range
          label="Maxhyra"
          min={1000}
          max={MAX_RENT}
          step={500}
          formatter={x => formatter.rent(x, MAX_RENT)}
          onChange={rent => this.setState({rent})}
        />
        <MultiSelect
          label="Antal rum"
          rooms={[
            {value: 1, text: "1"},
            {value: 2, text: "2"},
            {value: 3, text: "3"},
            {value: 4, text: "4"},
            {value: 5, text: "5"},
            {value: 6, text: "6"},
            {value: 7, text: "7"},
            {value: MAX_ROOMS, text: "8+"}
          ]}
          selected={this.state.rooms}
          onChange={rooms => this.setState({rooms})}
        />
        <button
          className="show-result"
          onClick={() => this.props.onSubmit(apartments)}
        >Se lägenheter <span>({apartments.length} st)</span></button>
      </div>
    );
  }
}

export default Filter;
