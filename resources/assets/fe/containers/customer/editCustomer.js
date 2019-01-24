import { connect } from "react-redux"
import EditCustomer from "../../components/customer/editCustomer";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        countries: state.default.env.countries,
        states: state.default.env.states,
        types: state.default.env.customer_type,
        employee: state.default.env.employee,
        filters: state.default.customer.filters,
        page_numer: state.default.customer.currentPage,
        customers: state.default.customer.customers
    }
}

export default connect(mapStateToProps)(EditCustomer);
