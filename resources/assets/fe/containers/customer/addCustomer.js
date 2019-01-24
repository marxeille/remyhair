import { connect } from "react-redux"
import AddCustomer from "../../components/customer/addCustomer";

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

export default connect(mapStateToProps)(AddCustomer);
