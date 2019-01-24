import { connect } from "react-redux"
import History from '../components/history'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        histories: state.default.history.history ? state.default.history.history  : {},
        currentPage: state.default.history.currentPage ? state.default.history.currentPage : {} ,
        pageLimit: state.default.history.pageLimit ? state.default.history.pageLimit : {},
        itemsPerPage: state.default.history.itemsPerPage ? state.default.history.itemsPerPage : {},
        totalItems: state.default.history.totalItems ? state.default.history.totalItems : {},
        isFetching:  state.default.history.isFetching,
        filters: state.default.history.filters ? state.default.history.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(History);
