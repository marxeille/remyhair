import { connect } from "react-redux"
import Size from "../../../components/report/order/Size";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.size.items,
        filters: state.default.report.order.size.filters,
    }
}

export default connect(mapStateToProps)(Size);
