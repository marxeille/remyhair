import { connect } from "react-redux"
import CustomerBalance from "../../../components/report/order/customerBalance";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.customerBalance.items,
        filters: state.default.report.order.customerBalance.filters,
    }
}

export default connect(mapStateToProps)(CustomerBalance);
