import { connect } from "react-redux"
import OrderSummary from "../../../components/report/order/orderSummary";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orderStatus: state.default.env.order_states,
        orders: state.default.report.order.summary.items,
        filters: state.default.report.order.summary.filters,
    }
}

export default connect(mapStateToProps)(OrderSummary);
