import { connect } from "react-redux"
import EditSupport from "../../components/support/editSupport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        payments: state.default.env.payments,
        states: state.default.env.states,
        invoices_status: state.default.env.invoices_status,
        employee: state.default.env.employee,
        filters: state.default.support.filters,
        page_numer: state.default.support.currentPage,
        customers: state.default.customer.customers,
        status: state.default.env.support_status,
        source: state.default.env.source,
    }
}

export default connect(mapStateToProps)(EditSupport);
