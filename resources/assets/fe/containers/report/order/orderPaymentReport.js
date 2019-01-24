import { connect } from "react-redux"
import OrderPaymentReport from "../../../components/report/order/orderPaymentReport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.payment.items,
        filters: state.default.report.order.payment.filters,
    }
}

export default connect(mapStateToProps)(OrderPaymentReport);
