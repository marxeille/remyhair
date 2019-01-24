import { connect } from "react-redux"
import AddEmployeeFamily from "../../components/employee/addEmployeeFamify";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        groups: state.default.env.groups,
        leaders: state.default.employee.leaders ?  state.default.employee.leaders : {},
        filters: state.default.employee.filters,
        page_number: state.default.employee.currentPage,
        employees: state.default.employee.employees
    }
}

export default connect(mapStateToProps)(AddEmployeeFamily);
