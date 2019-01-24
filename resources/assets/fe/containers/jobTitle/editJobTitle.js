import { connect } from "react-redux"
import EditJobTitle from "../../components/jobTitle/editJobTitle";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        jobTitle: state.default.jobTitle.jobTitle,
        filters: state.default.payment.filters ? state.default.payment.filters : {},
        page_number: state.default.payment.currentPage ? state.default.payment.currentPage : 1,
        jobTitles: state.default.jobTitle.jobTitles,
    }
}

export default connect(mapStateToProps)(EditJobTitle);
