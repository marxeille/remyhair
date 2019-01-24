import { connect } from "react-redux"
import Sale from '../components/sale/order'
import * as _ from 'lodash'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        initData: state.default.sale.initData,
        isEditing: state.default.sale.isEditing,
        cart: state.default.sale.cart,
        products: state.default.sale.cart ? state.default.sale.cart.products : [],
        employee: state.default.env.employee,
        countries: state.default.env.countries,
        states: state.default.env.states,
        order: state.default.sale.order
    }
}

export default connect(mapStateToProps)(Sale);
