import { connect } from "react-redux"
import OrderCustomerReport from "../../../components/report/order/customer";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.customer.items,
        filters: state.default.report.order.customer.filters,
    }
}

export default connect(mapStateToProps)(OrderCustomerReport);
