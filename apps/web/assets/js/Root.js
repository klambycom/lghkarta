import React, {Component} from "react";
import ReactDOM from "react-dom";
import Map from "./Map";
import Filter from "./Filter";

class Root extends Component {
  constructor(props) {
    super(props);

    this.state = {
      selectedId: null,
      apartments: props.apartments
    };

    this.mapRef = React.createRef();
  }

  handleFilter(apartments) {
    ReactDOM
      .findDOMNode(this.mapRef.current)
      .scrollIntoView({behavior: "smooth", block: "start"});

    this.setState({apartments});
  }

  render() {
    return (
      <div>
        <div className="Header">
          <div className="container">
            <div className="filter">
              <header>
                <h1>Hitta lediga lägenheter i Malmö</h1>
              </header>
              <Filter apartments={this.props.apartments} onSubmit={apartments => this.handleFilter(apartments)} />
            </div>
            <div className="image">
              <img src="/images/image.png" alt="Karta och Turning torso" />
            </div>
          </div>
        </div>

        <Map
          googleMapURL="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places"
          loadingElement={<div style={{ height: `100%` }} />}
          containerElement={<div style={{ height: `100vh` }} />}
          mapElement={<div style={{ height: `100%` }} />}
          apartments={this.state.apartments}
          onClick={x => this.setState({selectedId: x.id})}
          selectedId={this.state.selectedId}
          ref={this.mapRef}
        />
      </div>
    );
  }
}

export default Root;
