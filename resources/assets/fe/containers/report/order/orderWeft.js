import { connect } from "react-redux"
import OrderWeft from "../../../components/report/order/orderWeft";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orderStatus: state.default.env.order_states,
        hairSizes: state.default.env.hair_sizes,
        hairStyles: state.default.env.hair_styles,
        orderDetailsWeft: state.default.report.order.weft.items,
        weftTypes: state.default.report.order.weft.weft_type,
        filters: state.default.report.order.weft.filters,
    }
}

export default connect(mapStateToProps)(OrderWeft);
