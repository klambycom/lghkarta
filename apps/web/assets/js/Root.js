import React, {Component} from "react";
import Map from "./Map";

class Root extends Component {
  constructor(props) {
    super(props);
    this.state = {selectedId: null};
  }

  handleOpenMarker(x) {
    console.log(x);
    this.setState({selectedId: x.id});
  }

  render() {
    console.log(this.props);

    return (
      <div>
        <div className="narrow">
          <h2>Sök lediga lägenheter</h2>
          <p>TODO</p>
        </div>

        <div className="narrow">
          <h2>Resultat</h2>
        </div>
        <Map
          googleMapURL="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places"
          loadingElement={<div style={{ height: `100%` }} />}
          containerElement={<div style={{ height: `800px` }} />}
          mapElement={<div style={{ height: `100%` }} />}
          apartments={this.props.apartments}
          onClick={x => this.handleOpenMarker(x)}
          selectedId={this.state.selectedId}
        />
      </div>
    );
  }
}

export default Root;
