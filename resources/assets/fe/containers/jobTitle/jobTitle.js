import { connect } from "react-redux"
import JobTitle from "../../components/jobTitle/jobTitle";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        jobTitles: state.default.jobTitle.jobTitles,
        currentPage: state.default.jobTitle.currentPage ? state.default.jobTitle.currentPage : {} ,
        pageLimit: state.default.jobTitle.pageLimit ? state.default.jobTitle.pageLimit : {},
        itemsPerPage: state.default.jobTitle.itemsPerPage ? state.default.jobTitle.itemsPerPage : {},
        totalItems: state.default.jobTitle.totalItems ? state.default.jobTitle.totalItems : {},
        isFetching:  state.default.jobTitle.isFetching,
        filters: state.default.jobTitle.filters ? state.default.jobTitle.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(JobTitle);
