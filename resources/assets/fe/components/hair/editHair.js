import React, { Component } from 'react'
import Loading  from '../layout/loading'
import Api from '../../api'
import * as _ from 'lodash'
import Input from "../partial/input";
import { receiveNewHair, requestHair, requestGetList} from "../../actions/hair";
import ClassNames from "classnames";


export default class EditHair extends Component{
    constructor(props) {
        super(props);
        this.state = {
            isFetching: true,
            errors: [],
            title: '',
            isInited: false,
            hair: this.props.hair,
        };
        this.errorMsg = 'Field is required';
        this.onSubmit = this.onSubmit.bind(this);
        this.onChangeValue = this.onChangeValue.bind(this);
        this.handleCheckbox = this.handleCheckbox.bind(this);
        this.handleStyleCheckbox = this.handleStyleCheckbox.bind(this);
        this.onExportType = this.onExportType.bind(this);
        this.handleExportCheckbox = this.handleExportCheckbox.bind(this);
    }

    componentWillMount(){
        this.props.dispatch(requestHair(this.props.jwt, this.props.match.params.id, this.props.match.params.type));
    }

    handleCheckbox(e) {
        const item = e.target.name;
        const isChecked = e.target.checked;
        let colors = this.state.hair.id_color;
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
            hair: Object.assign({}, this.state.hair, {
                id_color: colors
            }),
        });

    }

    handleExportCheckbox(e) {
        this.setState({
            hair: Object.assign({}, this.state.hair, {
                export: e.target.checked
            }),
        });
    }
    
    onExportType(e) {
        let export_type = e.target.value;
        this.setState({
            hair: Object.assign({}, this.state.hair, {
                export_type
            }),
        });
    }

    handleStyleCheckbox(e) {
        const item = parseInt(e.target.name);
        const isChecked = e.target.checked;
        let styles = this.state.hair.id_style;
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
            hair: Object.assign({}, this.state.hair, {
                id_style: styles
            }),
        });

    }

    componentWillReceiveProps(nextProps){
        if(!_.isEmpty(nextProps.hair)){
            const form = nextProps.hair
            this.setState({
                hair: form,
            })
        }
    }

    componentDidUpdate(){
	    const { hair, isFetching, isInited} = this.state
        if(!_.isEmpty(hair) && isFetching && !isInited ){
	        this.setState({
                isFetching: false,
                isInited: true,
            })
        }
    }

    async onSubmit(){
	    const { hair } = this.state;
	    const data = _.clone(hair);
	    const dataToFetch = _.clone(hair);
        const errors = {
            name: !hair.name ? this.errorMsg : '',
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
          
           hair.page_number = this.props.page_number;
            Api.editHair(this.props.jwt, hair, this.props.match.params.type).then((response) => {
                const result = JSON.parse(response.text);
                if(result.status){
                    if(!_.isEmpty(this.props.hairs)){
                        const hairs = this.props.hairs.map((hair) => {
                            if(hair.id == result.data.hair.id){
                                return result.data.hair
                            }else return hair
                        })
                        this.props.dispatch(receiveNewHair(hairs));
                    }else{
                        this.props.dispatch(requestGetList(this.props.jwt));
                    }
                    this.props.history.push('/hair/list/' + this.props.match.params.type)
                }else{
                    this.setState({
                        isFetching: false,
                        errors: result.data,
                        hair: data
                    });
                }
            }).catch((errors)=>{
                alert(errors.message)
            })


        }
    }

    onChangeValue(require, event){
	    const state = {
            hair: Object.assign({}, this.state.hair, {
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

    renderHairColor(colors) {
        return (
            <div>
                <p>Hair Colors</p>
                <div className="box-body">
                    {this.props.hairColors.map((color) => (
                        <div className="custom-row"><input type="checkbox" name={color.id} onChange={this.handleCheckbox} checked={ colors.indexOf(color.id.toString()) !== -1 ? 'checked' : false } /><p>{color.name}</p></div>
                    ))}
                </div>
                
            </div>
        );
    }

    renderHairStyles(styles) {
       
        return (
            <div>
                <p>Hair Styles</p>
                <div className="box-body">
                    {this.props.hairStyles.map((style) => (
                        <div className="custom-row"><input type="checkbox" name={style.id} onChange={this.handleStyleCheckbox} checked={ styles.indexOf(style.id) !== -1 ? 'checked' : false } /><p>{style.name}</p></div>
                    ))}
                </div>
                
            </div>
        );
    }

    render() {
        const { errors , hair, isFetching } = this.state;
        if(isFetching) return <Loading/>
        return(
            <div className="">
                {isFetching ?  <Loading/> :
                    <div className="box box-primary box-edit-employee edit-hair-style">
                        <div className="box-header text-center">
                            <h4>Edit Hair {this.props.match.params.type}</h4>
                        </div>
                        
                        <form>
                            <div className="box-body" >
                                <Input onChangeValue={this.onChangeValue.bind(this, true)} title={'Name *'} name={'name'}
                                       placeholder={'Enter name'} error={errors.name} type={'text'} value={hair.name}/>

                                { this.props.match.params.type == 'type' 
                                ?
                                    <div className="form-group">
                                        <p><h5>Export type</h5></p>
                                        <select name="export_type" defaultValue={hair.export_type} onChange={this.onExportType} className="form-control">
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
                                        <p><input type="checkbox" onChange={this.handleExportCheckbox} checked={hair.export ? 'checked' : ''} />Export</p>
                                    </div>
                                : 
                                null}

                                {
                                    (this.props.match.params.type == 'style' && typeof hair.id_color !== 'undefined' && !_.isEmpty(hair)) ?
                                        this.renderHairColor(hair.id_color)
                                    : 
                                    null
                                    
                                }
                                {
                                    (this.props.match.params.type == 'type' && typeof hair.id_style !== 'undefined' && !_.isEmpty(hair)) ?
                                        this.renderHairStyles(hair.id_style)
                                    : 
                                    null
                                    
                                }
                                <div className="box-footer">
                                    <button type="button" onClick={() => this.props.history.push('/hair/list/' + this.props.match.params.type)} className="btn btn-default">Back</button>
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
