import React, { Component } from "react";
import Loading from "../layout/loading";
import Api from "../../api";
import * as _ from "lodash";
import Input from "../partial/input";
import LeaderList from "./leaderList";
import {
    addEmployee,
    receiveNewEmployee,
    requestGetList,
    requestLeaders
} from "../../actions/employee";
import ClassNames from "classnames";
import { config } from "../../constant";
import DatePicker from "react-datepicker";
import moment from "frozen-moment";
import "react-datepicker/dist/react-datepicker.css";

export default class AddEmployee extends Component {
    constructor(props) {
        super(props);
        const date = moment();
        this.state = {
            groups: this.props.groups,
            errors: [],
            title: "",
            form: {
                id_group: "",
                address: "",
                email: "",
                phone: "",
                name: "",
                date_of_birth: date,
                join_date: date,
                date_of_contract: date,
                facebook: "",
                password: "",
                education: "",
                school: "",
                major: "",
                date_of_graduation: moment(),
                filters: this.props.filters,
                page_number: this.props.page_number
            }
        };
        this.errorMsg = "Field is required";
        this.onChangeDate = this.onChangeDate.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    async onSubmit() {
        const { form } = this.state;
        const data = _.clone(form);
        const dataToFetch = _.clone(form);
        const errors = {
            id_group: !form.id_group ? this.errorMsg : "",
            address: !form.address ? this.errorMsg : "",
            email: !form.email ? this.errorMsg : "",
            phone: !form.phone ? this.errorMsg : "",
            name: !form.name ? this.errorMsg : "",
            password: !form.password ? this.errorMsg : ""
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
            form.date_of_birth = dataToFetch.date_of_birth.format(
                "YYYY-MM-DD"
            );
            form.join_date = dataToFetch.join_date.format(
                "YYYY-MM-DD"
            );
            form.date_of_contract = dataToFetch.date_of_contract.format(
                "YYYY-MM-DD"
            );
            form.date_of_graduation = dataToFetch.date_of_graduation.format(
                "YYYY-MM-DD"
            );
            Api.addEmployee(this.props.jwt, form)
                .then(response => {
                    const result = JSON.parse(response.text);
                    if (result.status) {
                        if(!_.isEmpty(this.props.employees)){
                            const employees = _.concat(this.props.employees, result.data.employee)
                            this.props.dispatch(receiveNewEmployee(employees))
                        }else{
                            this.props.dispatch(requestGetList(this.props.jwt));
                        }
                        this.props.history.push("/employee");
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
            if (event.target.name == "email") {
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]:
                        !event.target.value ||
                        !event.target.value.match(config.emailMatch)
                            ? this.errorMsg
                            : ""
                });
            } else if (event.target.name == "phone") {
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]:
                        !event.target.value ||
                        !event.target.value.match(config.phoneMatch)
                            ? this.errorMsg
                            : ""
                });
            } else {
                state.errors = Object.assign({}, this.state.errors, {
                    [event.target.name]: !event.target.value
                        ? this.errorMsg
                        : ""
                });
            }
        }
        this.setState(state);
    }

    onChangeDate(field, date) {
        this.setState({
            form: Object.assign({}, this.state.form, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    render() {
        const { errors, form, isFetching, groups, leaders } = this.state;
        return (
            <div className="">
                {isFetching ? (
                    <Loading />
                ) : (
                    <div className="box box-primary box-add-employee">
                        <div className="box-header text-center">
                            <h4>Add Employee</h4>
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
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Email *"}
                                    name={"email"}
                                    placeholder={"Enter email"}
                                    error={errors.email}
                                    type={"email"}
                                    value={form.email}
                                />
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Phone *"}
                                    name={"phone"}
                                    placeholder={"Enter phone"}
                                    error={errors.phone}
                                    type={"text"}
                                    value={form.phone}
                                />
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Password *"}
                                    name={"password"}
                                    placeholder={"Enter password"}
                                    error={errors.password}
                                    type={"password"}
                                    value={form.password}
                                />
                                <div
                                    className={ClassNames(
                                        { "form-group": true },
                                        { "has-error": errors.id_group }
                                    )}
                                >
                                    <label>Group</label>
                                    <select
                                        name="id_group"
                                        className={"form-control"}
                                        defaultValue={form.id_group}
                                        onChange={this.onChangeValue.bind(
                                            this,
                                            true
                                        )}
                                    >
                                        <option value="" defaultChecked={true}>
                                            --
                                        </option>
                                        {groups.map((group, i) => (
                                            <option value={group.id} key={i}>
                                                {group.name}
                                            </option>
                                        ))}
                                    </select>
                                    <span
                                        className={ClassNames(
                                            { "help-block": true },
                                            { hidden: !errors.id_group }
                                        )}
                                    >
                                        {errors.id_group}
                                    </span>
                                </div>
                                <div className={"group-date"}>
                                    <div className={"form-group"}>
                                        <label>Date of birth</label>
                                        <br />
                                        <DatePicker
                                            showYearDropdown
                                            selected={form.date_of_birth}
                                            onChange={this.onChangeDate.bind(
                                                this,
                                                "date_of_birth"
                                            )}
                                            className="form-control"
                                        />
                                    </div>
                                    <div className={"form-group"}>
                                        <label>Join date</label>
                                        <br />
                                        <DatePicker
                                            showYearDropdown
                                            selected={form.join_date}
                                            onChange={this.onChangeDate.bind(
                                                this,
                                                "join_date"
                                            )}
                                            className="form-control"
                                        />
                                    </div>
                                    <div className={"form-group"}>
                                        <label>Date of constract</label>
                                        <br />
                                        <DatePicker
                                            showYearDropdown
                                            selected={form.date_of_contract}
                                            onChange={this.onChangeDate.bind(
                                                this,
                                                "date_of_contract"
                                            )}
                                            className="form-control"
                                        />
                                    </div>
                                </div>
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        true
                                    )}
                                    title={"Address *"}
                                    name={"address"}
                                    placeholder={"Enter address"}
                                    error={errors.address}
                                    type={"text"}
                                    value={form.address}
                                />
                                <Input
                                    onChangeValue={this.onChangeValue.bind(
                                        this,
                                        false
                                    )}
                                    title={"Facebook "}
                                    name={"facebook"}
                                    placeholder={"Enter facebook"}
                                    type={"text"}
                                    value={form.facebook}
                                />
                                <div className={"group-inform"}>
                                    <Input
                                        onChangeValue={this.onChangeValue.bind(
                                            this,
                                            false
                                        )}
                                        title={"Education "}
                                        name={"education"}
                                        placeholder={"Enter education"}
                                        type={"text"}
                                        value={form.education}
                                    />
                                    <Input
                                        onChangeValue={this.onChangeValue.bind(
                                            this,
                                            false
                                        )}
                                        title={"School"}
                                        name={"school"}
                                        placeholder={"Enter school"}
                                        type={"text"}
                                        value={form.school}
                                    />
                                    <Input
                                        onChangeValue={this.onChangeValue.bind(
                                            this,
                                            false
                                        )}
                                        title={"Major"}
                                        name={"major"}
                                        placeholder={"Enter major"}
                                        type={"text"}
                                        value={form.major}
                                    />
                                    <div className={"form-group date-gradua"}>
                                        <label>Date of graduation</label>
                                        <br />
                                        <DatePicker
                                            showYearDropdown
                                            selected={form.date_of_graduation}
                                            onChange={this.onChangeDate.bind(
                                                this,
                                                "date_of_graduation"
                                            )}
                                            className="form-control"
                                        />
                                    </div>
                                </div>
                                <div className="box-footer">
                                    <button
                                        type="button"
                                        onClick={() =>
                                            this.props.history.push("/employee")
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
        );
    }
}
