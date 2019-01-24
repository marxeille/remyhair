import { connect } from "react-redux"
import SaleCommission from "../../components/saleCommission/saleCommission";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        saleCommissions: state.default.saleCommission.saleCommissions ? state.default.saleCommission.saleCommissions  : {},
        isFetching:  state.default.saleCommission.isFetching,
        filters: state.default.saleCommission.filters ? state.default.saleCommission.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(SaleCommission);
