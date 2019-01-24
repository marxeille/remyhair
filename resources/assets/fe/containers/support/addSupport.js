import { connect } from "react-redux"
import AddSupport from "../../components/support/addSupport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        states: state.default.env.states,
        invoices_status: state.default.env.invoices_status,
        employee: state.default.env.employee,
        filters: state.default.support.filters,
        page_numer: state.default.support.currentPage,
        customers: state.default.customer.customers,
        supportStatus: state.default.env.support_status,
        source: state.default.env.source,
    }
}

export default connect(mapStateToProps)(AddSupport);
