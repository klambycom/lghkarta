import React, {Component} from "react";
import formatter from "./formatter";
import settings from "./settings";
import MultiSelect from "./MultiSelect";
import Range from "./Range";
import History from "./History";

const check = {
  rooms(nr_of_rooms, selected) {
    if (selected.length === 0) { return true; }

    // Check if the apartment have the selected amount of rooms or more than max
    // if that is selected.
    return (selected.includes(settings.rooms.MAX) && nr_of_rooms > settings.rooms.MAX) || selected.includes(nr_of_rooms);
  },

  rent(sum, selected_max) {
    return selected_max === settings.rent.MAX || selected_max >= sum
  }
};

class Filter extends Component {
  constructor(props) {
    super(props);

    this.state = {
      rent: settings.rent.MAX,
      rooms: [],
      types: ["apartment", "new_construction"],
      history: []
    };
  }

  handleSubmit(apartments) {
    if (this.state.rent < settings.rent.MAX || this.state.rooms.length > 0) {
      const history = [{rent: this.state.rent, rooms: this.state.rooms}, ...this.state.history].slice(0, 3);
      this.setState({history});
    }

    this.props.onSubmit(apartments);
  }

  render() {
    const apartments = this.props.apartments
      .filter(x => check.rooms(+x.facts.rooms, this.state.rooms))
      .filter(x => check.rent(+x.facts.rent, this.state.rent))
      .filter(x => this.state.types.includes(x.type));

    return (
      <div className="Filter">
        <h2>Filtrera</h2>
        <Range
          label="Maxhyra"
          min={settings.rent.MIN}
          max={settings.rent.MAX}
          step={settings.rent.STEP}
          value={this.state.rent}
          formatter={x => formatter.rent(x, settings.rent.MAX)}
          onChange={rent => this.setState({rent})}
        />
        <MultiSelect
          label="Antal rum"
          options={settings.rooms.VALUES}
          selected={this.state.rooms}
          formatter={x => formatter.rooms(x, settings.rooms.MAX, settings.rooms.VALUES)}
          onChange={rooms => this.setState({rooms})}
        />
        <MultiSelect
          label="Lägenhetstyp"
          options={Object.keys(settings.TYPES).map(value => ({value, text: settings.TYPES[value]}))}
          selected={this.state.types}
          formatter={x => x.map(x => settings.TYPES[x]).join(", ")}
          onChange={types => this.setState({types})}
        />
        <button className="show-result" onClick={() => this.handleSubmit(apartments)}>
          Se lägenheter <span>({apartments.length} st)</span>
        </button>
        <History items={this.state.history} onClick={state => this.setState(state)} />
      </div>
    );
  }
}

export default Filter;
