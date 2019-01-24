import React, {PureComponent} from 'react';
import {renderAddress, showPrice} from "../../../utility";

export default class Products extends PureComponent{
    render(){
        const {hair_colors, hair_styles, hair_types, hair_draw, hair_sizes } = this.props.env;
        return(
            <div className="row">
                <div className="col-xs-12 table-responsive">
                    <table className="table table-striped table-product">
                        <thead>
                        <tr>
                            <th>Kg</th>
                            <th>Size</th>
                            <th>Type</th>
                            <th>Style</th>
                            <th>Color</th>
                            <th>Drawn</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                        </thead>
                        <tbody>
                        {this.props.orderDetail.map((orderDetail) => (
                            <tr key={orderDetail.id}>
                                <td>{orderDetail.kg}</td>
                                <td>{_.first(_.filter(hair_sizes, (size) => size.id == orderDetail.id_hair_size)).name}</td>
                                <td>{_.first(_.filter(hair_types, (type) => type.id == orderDetail.id_hair_size)).name}</td>
                                <td>{_.first(_.filter(hair_styles, (style) => style.id == orderDetail.id_hair_style)).name}</td>
                                <td>{_.first(_.filter(hair_colors, (color) => color.id == orderDetail.id_hair_color)).name}</td>
                                <td>{_.first(_.filter(hair_draw, (draw) => draw.id == orderDetail.id_hair_draw)).name}</td>
                                <td>{showPrice(orderDetail.price)}</td>
                                <td>{showPrice(orderDetail.total)}</td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </div>
        )
    }
}
