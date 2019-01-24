import React, { Component } from 'react'
import ClassNames from "classnames";
import * as _ from 'lodash'
import Loading from "../../layout/loading";
import {requestAddProduct} from "../../../actions/order/product";

export default class AddProduct extends Component{
    constructor(props){
        super(props);
        this.defaultValue = {
            id_cart: this.props.cart.id,
            id_hair_size: _.first(this.props.initData.hair_sizes).id,
            id_hair_color: _.first(this.props.initData.hair_colors).id,
            id_hair_draw: _.first(this.props.initData.hair_draws).id,
            id_hair_style: _.first(this.props.initData.hair_styles).id,
            id_hair_type: _.first(this.props.initData.hair_types).id,
            kg:'',
            price: ''
        };

        this.state = {
            initData: this.props.initData,
            cart: this.props.cart,
            defaultValue: this.defaultValue,
            errors: {
                kg: false,
                price: false
            },
            isFetching: false
        };
        this.onChangeValue = this.onChangeValue.bind(this);
        this.addProduct = this.addProduct.bind(this);
    }

    onChangeValue(event){
        if(event.target.name == 'kg'){
           this.setState({
                     defaultValue: Object.assign({}, this.state.defaultValue, {
                      kg: (_.isNull(event.target.value.match(/[^0-9.-]/)))
                          ? event.target.value : this.state.defaultValue.kg
                }),
                    errors: Object.assign({}, this.state.errors, {kg: !event.target.value})})

        }else if(event.target.name == 'price'){
           this.setState({
                    defaultValue: Object.assign({}, this.state.defaultValue, {
                        price:  (_.isNull( event.target.value.match(/[^0-9.-]/)))
                            ? event.target.value : this.state.defaultValue.price
                    }),
                    errors: Object.assign({}, this.state.errors, {price: !event.target.value})})

        }else{
            this.setState({
                defaultValue: Object.assign({}, this.state.defaultValue, {
                    [event.target.name]: event.target.value
                }),
                errors: Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value)
                })
            });
        }
    }

    onError(data){
       this.setState({
           errors: data
       })
    }

    addProduct(){
        if(!_.size(_.filter(this.state.errors, (err) => { return err } )) && this.state.defaultValue.kg && this.state.defaultValue.price){
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestAddProduct(this.props.jwt, this.state.defaultValue, this.props.isEditing, this.props.onSuccess.bind(this) , this.onError.bind(this)))
        }
    }

    render(){
        const { hair_sizes, hair_colors, hair_draws, hair_styles, hair_types } = this.state.initData;
        const { id_hair_size, id_hair_color, id_hair_draw, id_hair_style, id_hair_type, kg, price } = this.state.defaultValue;
        const total =  ( parseInt(kg) * parseFloat(price) ) ?  parseInt(kg) * parseFloat(price) : 0;
        if(this.state.isFetching) return <Loading/>
        return (
            <div className="box popup-add-product">
                <button className="btn-close-popup" onClick={this.props.onClose}></button>
                <div className="box-title">
                    <h3 className="title-form">Add Product</h3>
                </div>
                <div className="box-body">
                    <div className="row">
                        <div className={ClassNames({'form-group': true}, {'col-xs-12 col-md-4': true}, {'has-error': this.state.errors.id_hair_size})}>
                            <label className={'control-label'}>Size</label>
                            <select name="id_hair_size" className={'form-control'} defaultValue={id_hair_size} onChange={this.onChangeValue}>
                                {hair_sizes.map((size, key) => (
                                    <option key={key} value={size.id}>{size.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className={ClassNames({'form-group': true}, {'col-xs-12 col-md-4': true}, {'has-error': this.state.errors.id_hair_type})}>
                            <label className={'control-label'}>Type</label>
                            <select name="id_hair_type" className={'form-control'} defaultValue={id_hair_type} onChange={this.onChangeValue}>
                                {hair_types.map((type, key) => (
                                    <option key={key} value={type.id}>{type.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className={ClassNames({'form-group': true}, {'col-xs-12 col-md-4': true}, {'has-error': this.state.errors.id_hair_style})}>
                            <label className={'control-label'}>Style</label>
                            <select name="id_hair_style" className={'form-control'} defaultValue={id_hair_style} onChange={this.onChangeValue}>
                                {hair_styles.map((style, key) => (
                                    <option key={key} value={style.id}>{style.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className={ClassNames({'form-group': true}, {'col-xs-12 col-md-6': true}, {'has-error': this.state.errors.id_hair_color})}>
                            <label className={'control-label'}>Color</label>
                            <select name="id_hair_color" className={'form-control'} defaultValue={id_hair_color} onChange={this.onChangeValue}>
                                {hair_colors.map((color, key) => (
                                    <option key={key} value={color.id}>{color.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className={ClassNames({'form-group': true}, {'col-xs-12 col-md-6': true}, {'has-error': this.state.errors.id_hair_draw})}>
                            <label className={'control-label'}>Drawn</label>
                            <select name="id_hair_draw" className={'form-control'} defaultValue={id_hair_draw} onChange={this.onChangeValue}>
                                {hair_draws.map((draw, key) => (
                                    <option key={key} value={draw.id}>{draw.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className={ClassNames({'form-group input-kg': true}, {'col-xs-12 col-md-6': true}, {'has-error': this.state.errors.kg})}>
                            <input type="text" className="form-control" min={0} value={kg} name={'kg'} placeholder={'Kg'} onChange={this.onChangeValue} />
                        </div>
                        <div className={ClassNames({'form-group input-price': true}, {'col-xs-12 col-md-6': true}, {'has-error': this.state.errors.price})}>
                            <input type='text' className="form-control" min={0} value={price} name={'price'} placeholder={'Price'} onChange={this.onChangeValue} />
                        </div>
                        <div className={ClassNames({'form-group label-total-input': true}, {'col-xs-12 col-md-12': true}, {'has-error': this.state.errors.price})}>
                            <label className={'control-label'}>Total: {parseFloat(total)}</label>
                        </div>
                        <button className={ClassNames({'btn-add-product': true})} disabled={_.size(_.filter(this.state.errors, (err) => { return err } )) || !this.state.defaultValue.kg && !this.state.defaultValue.price} onClick={this.addProduct}>Add</button>
                    </div>
                </div>
            </div>
        )
    }
}
