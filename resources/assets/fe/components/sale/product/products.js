import React, { Component } from 'react'
import * as _ from 'lodash'
import Product from "./product";


export default class Products extends Component{
    constructor(props){
        super(props)
        this.state = {
            products: this.props.products,
            initData: this.props.initData,
        }
    }

    componentWillReceiveProps(nextProps){
        this.setState({
            products: nextProps.products,
        })
    }

    render(){
        const { products, initData } = this.state
        return (
            <div className="list-product-order">
                <table id="list-product-info">
                    <thead>
                    <tr>
                        <th>Size</th>
                        <th>Type</th>
                        <th>Style</th>
                        <th>Color</th>
                        <th>Drawn</th>
                        <th className="width-small">kG</th>
                        <th className="width-small">Price</th>
                        <th className="width-small">Total</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    {!_.isEmpty(products) &&
                        _.values(products).map((product) => (
                            <Product key={product.id} isEditing={this.props.isEditing} product={product} dispatch={this.props.dispatch} jwt={this.props.jwt} initData={initData} />
                        ))
                    }
                    </tbody>
                </table>
            </div>
        )
    }
}
