import { connect } from "react-redux"
import OrderStats from "../../../components/report/order/orderStats";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orderStatus: state.default.env.order_states,
        hairSizes: state.default.env.hair_sizes,
        orders: state.default.report.order.stats.items,
        filters: state.default.report.order.stats.filters,
    }
}

export default connect(mapStateToProps)(OrderStats);
