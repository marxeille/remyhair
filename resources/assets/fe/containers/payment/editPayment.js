import { connect } from "react-redux"
import EditPayment from "../../components/payment/editPayment";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        payment: state.default.payment.payment,
        filters: state.default.payment.filters ? state.default.payment.filters : {},
        page_number: state.default.payment.currentPage ? state.default.payment.currentPage : 1,
        payments: state.default.payment.payments,
    }
}

export default connect(mapStateToProps)(EditPayment);
