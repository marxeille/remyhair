import React, { Component } from 'react'
import Loading  from '../layout/loading'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import { requestJobTitle, requestGetList, receiveNewJobTitle} from "../../actions/jobTitle";
import ClassNames from "classnames";


export default class EditJobTitle extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            errors: [],
            title: '',
            isInited: false,
            jobTitle: this.props.jobTitle,
        };
        this.errorMsg = 'Field is required';
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
    }

    componentWillMount(){
        this.props.dispatch(
            requestJobTitle(this.props.jwt, this.props.match.params.id)
        );
    }

    componentWillReceiveProps(nextProps){
        if(!_.isEmpty(nextProps.jobTitle)){
            const form = nextProps.jobTitle
            this.setState({
                jobTitle: form,
            })
        }
    }

    componentDidUpdate(){
	    const { jobTitle, isFetching, isInited} = this.state;
        if(!_.isEmpty(jobTitle) && isFetching && !isInited ){
	        this.setState({
                isFetching: false,
                isInited: true,
            })
        }
    }

    async onSubmit(){
	    const { jobTitle } = this.state;
        const errors = {
            title: !jobTitle.title ? this.errorMsg : '',
        };
        if(_.size(_.filter(errors, (error) => {
            return error;
        }))){
           this.setState({
               errors: errors
           })
        }else{
           this.setState({
               isFetching: true
           });
            Api.editJobTitle(this.props.jwt, jobTitle).then((response) => {
                const result = JSON.parse(response.text);
                if(result.status){
                    if(!_.isEmpty(this.props.jobTitles)){
                        const jobTitles = this.props.jobTitles.map((jobTitle) => {
                            if(jobTitle.id == result.data.id){
                                return result.data
                            }else return jobTitle
                        });
                        this.props.dispatch(receiveNewJobTitle(jobTitles));
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/job-title')
                }else{
                    this.setState({
                        isFetching: false,
                        errors: result.data,
                    });
                }
            }).catch((errors)=>{
                alert(errors.message)
            })


        }
    }

    onChangeValue(require, event){
	    const state = {
            jobTitle: Object.assign({}, this.state.jobTitle, {
                [event.target.name]: event.target.value
            })
        };
	    if(require){
            state.errors = Object.assign({}, this.state.errors, {
                [event.target.name]: (!event.target.value) ? this.errorMsg : ''
            })
        }
            this.setState(state);

    }

    render() {
        const { errors , jobTitle, isFetching } = this.state;
        if(isFetching) return <Loading/>
        return(
            <div className="">
                {isFetching ?  <Loading/> :
                    <div className="box box-primary box-edit-employee">
                        <div className="box-header text-center">
                            <h4>Edit Job title</h4>
                        </div>
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Title *'} name={'title'}
                                       placeholder={'Enter title'} error={errors.title} type={'text'} value={jobTitle.title}/>

                                <div className="box-footer">
                                    <button type="button" onClick={() => this.props.history.push('/job-title')} className="btn btn-default">Back</button>
                                    <button type="button" onClick={this.onSubmit.bind(this)} className="btn btn-info pull-right">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                }

            </div>
        )
    }
}
