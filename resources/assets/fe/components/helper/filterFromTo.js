import React, {Component} from 'react';
import DatePicker from "react-datepicker/es";
import moment from "frozen-moment";

export default class FilterFromTo extends Component{
    constructor(props){
        super(props);
        this.state = {
            filter: props.filter
        }
    }

    componentWillReceiveProps(props){
        this.setState({
            filter: props.filter
        })
    }

    render(){
        const {filter} = this.state;
        return(
            <div style={{float: 'left'}}>
                <div className="filter-from">
                    <span>From:</span>
                    <div className="datePicker">
                        <DatePicker
                            showYearDropdown
                            selected={ filter.from ? moment(filter.from) : null}
                            onChange={(value) => this.props.onChangeDate('from', value)}
                            className="form-control"
                            dateFormat="DD/MM/YYYY"
                        />
                    </div>
                </div>

                <div className="filter-to">
                    <span>To:</span>
                    <div className="datePicker">
                        <DatePicker
                            showYearDropdown
                            selected={ filter.to ? moment(filter.to) : null}
                            onChange={(value) => this.props.onChangeDate('to', value)}
                            className="form-control"
                            dateFormat="DD/MM/YYYY"
                        />
                    </div>
                </div>
            </div>
        )
    }
}
