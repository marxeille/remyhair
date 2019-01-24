import { connect } from "react-redux"
import Country from "../../../components/report/order/Country";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.report.order.country.items,
        filters: state.default.report.order.country.filters,
    }
}

export default connect(mapStateToProps)(Country);
