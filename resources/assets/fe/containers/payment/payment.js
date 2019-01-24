import { connect } from "react-redux"
import HairComponent from '../../components/hair/hair'
import Payment from "../../components/payment/payment";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        payments: state.default.payment.payments,
        currentPage: state.default.payment.currentPage ? state.default.payment.currentPage : {} ,
        pageLimit: state.default.payment.pageLimit ? state.default.payment.pageLimit : {},
        itemsPerPage: state.default.payment.itemsPerPage ? state.default.payment.itemsPerPage : {},
        totalItems: state.default.payment.totalItems ? state.default.payment.totalItems : {},
        isFetching:  state.default.payment.isFetching,
        filters: state.default.payment.filters ? state.default.payment.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(Payment);
