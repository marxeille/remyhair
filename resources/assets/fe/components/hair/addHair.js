import React, { Component } from "react";
import Loading from "../layout/loading";
import Api from "../../api";
import * as _ from "lodash";
import Input from "../partial/input";
import {
    addHair,
    receiveNewHair,
    requestGetList,
} from "../../actions/hair";
import ClassNames from "classnames";

export default class AddHair extends Component {
    constructor(props) {
        super(props);
        this.state = {
            errors: [],
            title: "",
            form: {
                name: "",
                colors: [],
                styles: [],
                export_type: "",
                export: false,
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = "Field is required";
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
        this.handleCheckbox = this.handleCheckbox.bind(this);
        this.handleStyleCheckbox = this.handleStyleCheckbox.bind(this);
        this.onExportType = this.onExportType.bind(this);
        this.handleExportCheckbox = this.handleExportCheckbox.bind(this);
    }

    handleCheckbox(e) {
        const item = e.target.name;
        const isChecked = e.target.checked;
        let colors = this.state.form.colors;
        if (isChecked) {
            if(colors.indexOf(item) == -1) {
                colors.push(item);
            }
        } else {
            if(colors.indexOf(item) !== -1) {
                colors.splice(colors.indexOf(item), 1);
            }
        }
        
        
        this.setState({
            form: Object.assign({}, this.state.form, {
                colors: colors
            }),
        });
    }

    handleExportCheckbox(e) {
        this.setState({
            form: Object.assign({}, this.state.form, {
                export: e.target.checked
            }),
        });
    }

    onExportType(e) {
        let export_type = e.target.value;
        this.setState({
            form: Object.assign({}, this.state.form, {
                export_type
            }),
        });
    }

    async onSubmit() {
        const { form } = this.state;
        const data = _.clone(form);
        const dataToFetch = _.clone(form);
        const errors = {
            name: !form.name ? this.errorMsg : "",
        };
        if (
            _.size(
                _.filter(errors, error => {
                    return error;
                })
            )
        ) {
            this.setState({
                errors: errors
            });
        } else {
            this.setState({
                isFetching: true
            });
            Api.addHair(this.props.jwt, form, this.props.match.params.type)
                .then(response => {
                    const result = JSON.parse(response.text);
                    if (result.status) {
                        if(!_.isEmpty(this.props.hairs)){
                            const hairs = _.concat(this.props.hairs, result.data.hair)
                            this.props.dispatch(receiveNewHair(hairs))
                        }else{
                            this.props.dispatch(requestGetList(this.props.jwt));
                        }
                        this.props.history.push("/hair/list/" + this.props.match.params.type);
                    } else {
                        this.setState({
                            isFetching: false,
                            errors: result.data,
                            form: data
                        });
                    }
                })
                .catch(errors => {
                    alert(errors.message());
                });
        }
    }

    onChangeValue(require, event) {
        const state = {
            form: Object.assign({}, this.state.form, {
                [event.target.name]: event.target.value
            })
        };
        if (require) {
            state.errors = Object.assign({}, this.state.errors, {
                [event.target.name]: !event.target.value
                    ? this.errorMsg
                    : ""
            });
        }
        this.setState(state);
    }

    rentderHairColors() {
        const {form} = this.state;
        return (
            <div>
                <p>Hair Colors</p>
                <div className="box-body">
                    {this.props.hairColors.map((color) => (
                        <p><input type="checkbox" name={color.id} onChange={this.handleCheckbox}/>{color.name}</p>
                    ))}
                </div>
                
            </div>
        );
    }

    renderHairStyles() {
        return (
            <div>
                <p>Hair Styles</p>
                <div className="box-body">
                    {this.props.hairStyles.map((style) => (
                        <div className="custom-row"><input type="checkbox" name={style.id} onChange={this.handleStyleCheckbox} /><p>{style.name}</p></div>
                    ))}
                </div>
                
            </div>
        );
    }

    handleStyleCheckbox(e) {
        const item = parseInt(e.target.name);
        const isChecked = e.target.checked;
        let styles = this.state.form.styles;
        if (isChecked) {
            if(styles.indexOf(item) == -1) {
                styles.push(item);
            }
        } else {
            if(styles.indexOf(item) !== -1) {
                styles.splice(styles.indexOf(item), 1);
            }
        }

        this.setState({
            form: Object.assign({}, this.state.form, {
                styles: styles
            }),
        });

    }


    render() {
        const { errors, form, isFetching } = this.state;
        return(
            <div>
                <div className="">
                {isFetching ? (
                    <Loading />
                ) : (
                    <div className="box box-primary box-add-employee">
                        <div className="box-header text-center">
                            <h4>Add Hair {this.props.match.params.type}</h4>
                        </div>
                        <form>
                            <div className="box-body">
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Name *"}
                                    name={"name"}
                                    placeholder={"Enter name"}
                                    error={errors.name}
                                    type={"text"}
                                    value={form.name}
                                />
                                
                                { this.props.match.params.type == 'type' 
                                ?
                                    <div className="form-group">
                                        <p><h5>Export type</h5></p>
                                        <select name="export_type" onChange={this.onExportType} className="form-control">
                                            <option value="DEFAULT">DEFAULT</option>
                                            <option value="BULK">BULK</option>
                                            <option value="CLOSURE">CLOSURE</option>
                                            <option value="WEFT">WEFT</option>
                                        </select>
                                    </div>
                                : 
                                null}

                                { this.props.match.params.type == 'style' 
                                ?
                                    <div className="form-group">
                                        <p><input type="checkbox" onChange={this.handleExportCheckbox}/>Export</p>
                                    </div>
                                : 
                                null}
                                
                                { this.props.match.params.type == 'style' 
                                ?
                                    this.rentderHairColors()
                                : 
                                null}

                                { this.props.match.params.type == 'type' 
                                ?
                                    this.renderHairStyles()
                                : 
                                null}
                                <div className="box-footer">
                                    <button
                                        type="button"
                                        onClick={() =>
                                            this.props.history.push("/hair/list/" + this.props.match.params.type)
                                        }
                                        className="btn btn-default"
                                    >
                                        Back
                                    </button>
                                    <button
                                        type="button"
                                        onClick={this.onSubmit.bind(this)}
                                        className="btn btn-info pull-right"
                                    >
                                        Save
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                )}
            </div>
            </div>
        );
    }
}
    
