import { connect } from "react-redux"
import AddPayment from "../../components/payment/addPayment";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        filters: state.default.hair.filters,
        page_number: state.default.hair.currentPage,
        payments: state.default.payment.payments
    }
}

export default connect(mapStateToProps)(AddPayment);
