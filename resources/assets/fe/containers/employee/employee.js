import { connect } from "react-redux"
import Employee from "../../components/employee/employee";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        employees: state.default.employee.employees ? state.default.employee.employees  : {},
        currentPage: state.default.employee.currentPage ? state.default.employee.currentPage : 1,
        pageLimit: state.default.employee.pageLimit ? state.default.employee.pageLimit : {},
        itemsPerPage: state.default.employee.itemsPerPage ? state.default.employee.itemsPerPage : 0,
        totalItems: state.default.employee.totalItems ? state.default.employee.totalItems : 0,
        isFetching:  state.default.employee.isFetching,
        filters: state.default.employee.filters ? state.default.employee.filters : {},
        groups: state.default.env.groups,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(Employee);
