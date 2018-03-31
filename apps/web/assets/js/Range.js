import React, {Component} from "react";

class Range extends Component {
  constructor(props) {
    super(props);
    this.state = {value: props.max};
  }

  handleChange(e) {
    this.setState({value: +e.target.value});
    this.props.onChange(+e.target.value);
  }

  render() {
    let valueTxt = this.state.value;
    if (this.props.formatter) {
      valueTxt = this.props.formatter(this.state.value);
    }

    return (
      <div className="Range">
        <div className="label">
          <span>{this.props.label}</span>
          <span className="value">{valueTxt}</span>
        </div>
        <div>
          <input
            type="range"
            min={this.props.min}
            max={this.props.max}
            step={this.props.step}
            value={this.state.value}
            onChange={(e) => this.handleChange(e)}
          />
        </div>
      </div>
    );
  }
}

export default Range;
