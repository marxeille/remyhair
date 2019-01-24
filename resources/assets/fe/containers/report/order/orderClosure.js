import { connect } from "react-redux"
import OrderClosure from "../../../components/report/order/orderClosure";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orderStatus: state.default.env.order_states,
        hairSizes: state.default.env.hair_sizes,
        hairTypes: state.default.env.hair_types,
        orders: state.default.report.order.closure.items,
        closureTypes: state.default.report.order.closure.closure_type,
        filters: state.default.report.order.closure.filters,
    }
}

export default connect(mapStateToProps)(OrderClosure);
