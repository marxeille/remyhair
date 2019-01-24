import { connect } from "react-redux"
import Type from "../../../components/report/order/type";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.type.items,
        filters: state.default.report.order.type.filters,
    }
}

export default connect(mapStateToProps)(Type);
