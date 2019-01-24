import { connect } from "react-redux"
import ListCustomer from "../../components/employee/listCustomer";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        customers: state.default.employee.customers.items ? state.default.employee.customers.items  : {},
        currentPage: state.default.employee.customers.currentPage ? state.default.employee.customers.currentPage : 1,
        pageLimit: state.default.employee.customers.pageLimit ? state.default.employee.customers.pageLimit : {},
        itemsPerPage: state.default.employee.customers.itemsPerPage ? state.default.employee.customers.itemsPerPage : 0,
        totalItems: state.default.employee.customers.totalItems ? state.default.employee.customers.totalItems : 0,
        isFetching:  state.default.employee.customers.isFetching,
        filters: state.default.employee.customers.filters ? state.default.employee.customers.filters : {},
        groups: state.default.env.groups,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(ListCustomer);
