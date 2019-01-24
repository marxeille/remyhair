import { connect } from "react-redux"
import EditWorkProfile from "../../components/workprofile/editWorkProfile";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        employees: state.default.env.employees,
        workCategories: state.default.env.work_category,
        workProfiles: state.default.workProfile.workProfiles,
        procedures: state.default.env.procedure,
        employee: state.default.env.employee,
        filters: state.default.workProfile.filters,
        page_numer: state.default.workProfile.currentPage,
        procedureSteps: state.default.env.procedure_step
    }
}

export default connect(mapStateToProps)(EditWorkProfile);
