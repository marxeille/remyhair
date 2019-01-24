import { connect } from "react-redux"
import WorkProfile from '../../components/workprofile/workprofile'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        workProfiles: state.default.workProfile.workProfiles,
        currentPage: state.default.workProfile.currentPage ? state.default.workProfile.currentPage : {} ,
        pageLimit: state.default.workProfile.pageLimit ? state.default.workProfile.pageLimit : {},
        itemsPerPage: state.default.workProfile.itemsPerPage ? state.default.workProfile.itemsPerPage : {},
        totalItems: state.default.workProfile.totalItems ? state.default.workProfile.totalItems : {},
        isFetching:  state.default.workProfile.isFetching,
        filters: state.default.workProfile.filters ? state.default.workProfile.filters : {},
        actions: state.default.env.actions,
    }
}

export default connect(mapStateToProps)(WorkProfile);
