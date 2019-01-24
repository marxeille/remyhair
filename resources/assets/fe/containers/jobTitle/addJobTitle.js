import { connect } from "react-redux"
import AddJobTitle from "../../components/jobTitle/addJobTitle";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        filters: state.default.hair.filters,
        page_number: state.default.hair.currentPage,
        jobTitles: state.default.jobTitle.jobTitles
    }
}

export default connect(mapStateToProps)(AddJobTitle);
