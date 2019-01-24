import React, { Component } from 'react'
import ClassNames from "classnames";
import * as _ from "lodash";
import Api from '../../../api'
import Spinner from "../../layout/spinner";
import {requestRemoveProduct, requestUpdateProduct} from "../../../actions/order/product";

export default class Product extends Component{
    constructor(props){
        super(props)
        this.state = {
            product: this.props.product,
            initData: this.props.initData,
            errors: {}
        }

        this.onChangeValue = this.onChangeValue.bind(this)
        this.onSubmit = this.onSubmit.bind(this)
        this.onSuccess = this.onSuccess.bind(this)
        this.onError = this.onError.bind(this)
        this.removeProduct = this.removeProduct.bind(this)
    }


    componentWillReceiveProps(nextProps){
        if(!_.isEqual(nextProps.product, this.props.product)){
            this.setState({
                product: nextProps.product,
                initData: nextProps.initData
            })
        }
    }

    removeProduct(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestRemoveProduct(this.props.jwt, this.state.product, this.props.isEditing, this.onSuccess, this.onError))
    }

    onChangeValue(event){
        if(event.target.name == 'kg'){
            this.setState({
                product: Object.assign({}, this.state.product, {
                    kg:(_.isNull(event.target.value.match(/[^0-9.-]/)))
                        ? event.target.value : this.state.product.kg
                }),
                errors: Object.assign({}, this.state.errors, {kg: !event.target.value})})

        }else if(event.target.name == 'price'){
            this.setState({
                product: Object.assign({}, this.state.product, {
                    price:  (_.isNull( event.target.value.match(/[^0-9.-]/)))
                        ? event.target.value : this.state.product.price
                }),
                errors: Object.assign({}, this.state.errors, {price: !event.target.value})})

        }else{
            this.setState({
                product: Object.assign({}, this.state.product, {
                    [event.target.name]: event.target.value
                }),
                errors: Object.assign({}, this.state.errors, {
                    [event.target.name]: (!event.target.value)
                })
            });
            this.onSubmit(Object.assign({}, this.state.product, {
                [event.target.name]: event.target.value
            }));
        }
    }

    onSuccess(){
        this.setState({
            isFetching: false
        })
    }

    onError(msg){
       alert(msg)
    }

   async onSubmit(product = null){
        if(!_.size(_.filter(this.state.errors, (err) => err))) {
            this.setState({
                isFetching: true
            });
            this.props.dispatch(requestUpdateProduct(this.props.jwt, product.id ? product : this.state.product, this.props.isEditing, this.onSuccess, this.onError))
        }
    }

    render(){
        const { product, isFetching } = this.state;
        const { hair_sizes, hair_colors, hair_draws, hair_styles, hair_types } = this.state.initData;
        return(
            <tr>
                <td>
                    <div className={ClassNames({'has-error': this.state.errors.id_hair_size})}>
                        <select name="id_hair_size" className={'form-control'} defaultValue={product.id_hair_size} onChange={this.onChangeValue}>
                            {hair_sizes.map((size) => (
                                <option value={size.id} key={size.id}>{size.name}</option>
                            ))}
                        </select>
                    </div>
                </td>
                <td>
                    <div className={ClassNames({'has-error': this.state.errors.id_hair_type})}>
                        <select name="id_hair_type" className={'form-control select'} defaultValue={product.id_hair_type} onChange={this.onChangeValue}>
                            {hair_types.map((type) => (
                                <option value={type.id}  key={type.id}>{type.name}</option>
                            ))}
                        </select>
                    </div>
                </td>
                <td>
                    <div className={ClassNames( {'has-error': this.state.errors.id_hair_style})}>
                        <select name="id_hair_style" className={'form-control'} defaultValue={product.id_hair_style} onChange={this.onChangeValue}>
                            {hair_styles.map((style) => (
                                <option value={style.id}  key={style.id}>{style.name}</option>
                            ))}
                        </select>
                    </div>
                </td>
                <td>
                    <div className={ClassNames({'has-error': this.state.errors.id_hair_color})}>
                        <select name="id_hair_color" className={'form-control'} defaultValue={product.id_hair_color} onChange={this.onChangeValue}>
                            {hair_colors.map((color) => (
                                <option value={color.id} key={color.id}>{color.name}</option>
                            ))}
                        </select>
                    </div>
                </td>
                <td>
                    <div className={ClassNames( {'has-error': this.state.errors.id_hair_draw})}>
                        <select name="id_hair_draw" className={'form-control'} defaultValue={product.id_hair_draw} onChange={this.onChangeValue}>
                            {hair_draws.map((draw) => (
                                <option value={draw.id} key={draw.id}>{draw.name}</option>
                            ))}
                        </select>
                    </div>
                </td>
                <td>
                    <div className={ClassNames( {'has-error': this.state.errors.kg})}>
                        <input type='text' className="form-control" min={0} value={product.kg} name={'kg'} placeholder={'Kg'} onChange={this.onChangeValue} onBlur={this.onSubmit} />
                    </div>
                </td>
                <td>
                    <div className={ClassNames( {'has-error': this.state.errors.price})}>
                        <input type="text" className="form-control" min={0} value={product.price} name={'price'} placeholder={'Price'} onChange={this.onChangeValue} onBlur={this.onSubmit}/>
                    </div>
                </td>
                <td>
                    <div>
                        {isFetching ? <Spinner/> :
                            <input type="text" disabled={true} className="form-control" min={0} value={product.total_price}  />
                        }
                    </div>
                </td>
                <td>
                    <button className={'btn btn-flat'} onClick={this.removeProduct}><i className={'fa  fa-close '}></i></button>
                </td>
            </tr>
        )
    }
}
