import { connect } from "react-redux"
import OrderDetail from "../../components/order/orderDetail";

function mapStateToProps(state) {
    return {
        order: state.default.order.order,
        jwt: state.default.env.jwt,
        isFetching:  state.default.order.isFetching,
        actions: state.default.env.actions,
        countries: state.default.env.countries,
        env: state.default.env,
    }
}

export default connect(mapStateToProps)(OrderDetail);
