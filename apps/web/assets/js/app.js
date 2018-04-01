// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
//import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import React from "react";
import ReactDOM from "react-dom";
import Root from "./Root";

const createApartment = x => {
  const facts = [...x.querySelectorAll("ul.facts li")].reduce((acc, fact) => {
    acc[fact.dataset.type] = fact.dataset.value;
    return acc;
  }, {});

  facts.area = +facts.area;
  facts.rooms = +facts.rooms;
  facts.rent = +x.dataset.rent;

  return {
    id: x.dataset.id,
    longitude: +x.dataset.longitude,
    latitude: +x.dataset.latitude,
    city: x.dataset.city,
    title: x.dataset.title,
    url: x.dataset.url,
    facts: facts
  };
};

const apartments = [...document.querySelectorAll(".apartment")].map(createApartment);

ReactDOM.render(<Root apartments={apartments} />, document.getElementById('root'));


// Toggle all apartments
(function () {
  var link = document.querySelector("#js-toggle-all-apartments");
  var apartments = document.querySelectorAll(".apartment.older");
  var hidden = true;

  link.style.display = "inline-block";
  apartments.forEach(e => e.style.display = "none");

  link.addEventListener("click", e => {
    if (hidden) {
      apartments.forEach(e => e.style.display = "block");
    }
    else {
      apartments.forEach(e => e.style.display = "none");
    }

    hidden = !hidden;
    e.preventDefault();
  });
}());

//import Result from "./Result";
//import logo from './logo.svg';
//import './App.css';
//
//class App extends Component {
//  constructor(props) {
//    super(props);
//    this.state = {selectedId: null};
//  }
//
//  handleOpenMarker(x) {
//    console.log(x);
//    this.setState({selectedId: x.id});
//  }
//
//  render() {
//    return (
//      <div className="App">
//        <header className="App-header">
//          <img src={logo} className="App-logo" alt="logo" />
//          <h1 className="App-title">Welcome to React</h1>
//        </header>
//        <div className="App-intro">
//          <Result
//            googleMapURL="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places"
//            loadingElement={<div style={{ height: `100%` }} />}
//            containerElement={<div style={{ height: `400px` }} />}
//            mapElement={<div style={{ height: `100%` }} />}
//            onClick={x => this.handleOpenMarker(x)}
//            selectedId={this.state.selectedId}
//          />
//        </div>
//      </div>
//    );
//  }
//}
//
//export default App;
