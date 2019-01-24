import React, { Component } from "react";
import Loading from "../layout/loading";
import Api from "../../api";
import * as _ from "lodash";
import Input from "../partial/input";
import {
    requestGetList,
} from "../../actions/jobTitle";
import {receiveNewJobTitle} from "../../actions/jobTitle";

export default class AddJobTitle extends Component {
    constructor(props) {
        super(props);
        this.state = {
            errors: [],
            title: "",
            form: {
                title: "",
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
            title: !form.title ? this.errorMsg : "",
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
            Api.addJobTitle(this.props.jwt, form)
                .then(response => {
                    const result = JSON.parse(response.text);
                    if (result.status) {
                        if(!_.isEmpty(this.props.jobTitles)){
                            const jobTitles = _.concat(this.props.jobTitles, result.data.jobTitle);
                            this.props.dispatch(receiveNewJobTitle(jobTitles))
                        }else{
                            this.props.dispatch(requestGetList(this.props.jwt));
                        }
                        this.props.history.push("/job-title");
                    } else {
                        this.setState({
                            isFetching: false,
                            errors: result.data.jobTitle,
                        });
                    }
                })
                .catch(errors => {
                    alert(errors.message);
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
                            <h4>Add job title </h4>
                        </div>
                        <form>
                            <div className="box-body">
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Title *"}
                                    name={"title"}
                                    placeholder={"Enter title"}
                                    error={errors.title}
                                    type={"text"}
                                    value={form.title}
                                />
                                <div className="box-footer">
                                    <button
                                        type="button"
                                        onClick={() =>
                                            this.props.history.push("/job-title")
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
    
