import React, { Component } from "react";
import Loading from "../layout/loading";
import Api from "../../api";
import * as _ from "lodash";
import Input from "../partial/input";
import {
    requestGetList,
} from "../../actions/payment";
import {receiveNewPayment} from "../../actions/payment";

export default class AddPayment extends Component {
    constructor(props) {
        super(props);
        this.state = {
            errors: [],
            title: "",
            form: {
                name: "",
                fee: 0,
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = "Field is required";
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    async onSubmit() {
        const { form } = this.state;
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
            Api.addPayment(this.props.jwt, form)
                .then(response => {
                    const result = JSON.parse(response.text);
                    if (result.status) {
                        if(!_.isEmpty(this.props.payments)){
                            const payments = _.concat(this.props.payments, result.data.payment);
                            this.props.dispatch(receiveNewPayment(payments))
                        }else{
                            this.props.dispatch(requestGetList(this.props.jwt));
                        }
                        this.props.history.push("/payment");
                    } else {
                        this.setState({
                            isFetching: false,
                            errors: result.data.payment,
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
                            <h4>Add payment </h4>
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
                                <div className="box-footer">
                                    <button
                                        type="button"
                                        onClick={() =>
                                            this.props.history.push("/payment")
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
    
