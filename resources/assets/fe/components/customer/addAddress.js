import React, { Component } from 'react'
import * as _ from 'lodash'
import Input from "../partial/input";

export default class AddAddress extends Component{
    constructor(props) {
        super(props);
        const states = _.filter(this.props.states, (state) => {
            return state.id_country == (this.props.value) ? this.props.value.id_country :  _.first(this.props.countries).id
        });
        const selected = _.size(this.props.value) ? this.props.value : {
                id: this.props.id,
                id_country: _.first(this.props.countries).id,
                id_state: (_.first(states)) ? _.first(states).id : null,
                address: ''
        };
        this.errors = 'Address field is requried';
        this.props.onChangeAddress.bind(selected);
        this.state = {
            countries: this.props.countries,
            states: states,
            selected: selected,
            error: this.props.error
        };
    }


    onSelectCountry(event){
        const states =  _.filter(this.props.states, (state) => {
            return state.id_country == event.target.value
        });

        this.setState({
            states: states,
            selected : Object.assign(this.state.selected, {
                id_country : event.target.value,
                id_state: (_.first(states)) ? _.first(states).id : null,
            })
        })
    }

    onChangeAddress(event){
        this.setState({
            selected : Object.assign( this.state.selected, {
                address: event.target.value,
            }),
            error: (!event.target.value) ? this.errors : ''
        })
    }

    onSelectState(event){
        this.setState({
            selected : Object.assign(this.state.selected, {
                id_state: event.target.value
            })
        });
    }

    componentDidUpdate(prevProps, prevState, snapshot){
        if(prevProps == this.props){
            if(!this.state.selected.address) this.setState({ errors: this.errors});
            this.props.onChangeAddress(this.state.selected);
        }
    }

    componentWillReceiveProps(nextProps){
        if(nextProps.error) this.setState({error: nextProps.error})
        if(nextProps.value && _.size(nextProps.value)) this.setState({
            selected: nextProps.value
        });
    }

    render(){
        const { countries, states } = this.state;
        return (
                <div className="">
                    <div className="form-group">
                        <label>Country</label>
                        <select name="name" id="" className="form-control" defaultValue={this.state.selected.id_country} onChange={this.onSelectCountry.bind(this)}>
                                {countries.map((country) => (
                                    <option value={country.id} key={country.id}>{country.name}</option>
                                ))}
                        </select>
                    </div>
                    <div className="form-group">
                        <label >State</label>
                        <select name="name" className="form-control" defaultValue={this.state.selected.id_state} onChange={this.onSelectState.bind(this)}>
                            {states.map((state) => (
                                        <option value={state.id} key={state.id}>{state.name}</option>
                            ))}
                        </select>
                    </div>
                    <Input
                        onChangeValue={this.onChangeAddress.bind(this)} title={'Address *'} name={'address'}
                        placeholder={'Enter address'} error={this.state.error} type={'text'} value={this.state.selected.address}/>
                </div>
        )
    }
}
