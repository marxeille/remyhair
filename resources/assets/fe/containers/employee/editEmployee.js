import { connect } from "react-redux"
import EditEmployee from "../../components/employee/editEmployee";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        groups: state.default.env.groups,
        leaders: state.default.employee.leaders,
        employee: state.default.employee.employee,
        filters: state.default.employee.filters ? state.default.employee.filters : {},
        page_number: state.default.employee.currentPage ? state.default.employee.currentPage : 1,
        employees: state.default.employee.employees
    }
}

export default connect(mapStateToProps)(EditEmployee);
