import { connect } from "react-redux"
import HairComponent from '../../components/hair/hair'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        hairs: state.default.hair.hairs,
        currentPage: state.default.hair.currentPage ? state.default.hair.currentPage : {} ,
        pageLimit: state.default.hair.pageLimit ? state.default.hair.pageLimit : {},
        itemsPerPage: state.default.hair.itemsPerPage ? state.default.hair.itemsPerPage : {},
        totalItems: state.default.hair.totalItems ? state.default.hair.totalItems : {},
        isFetching:  state.default.hair.isFetching,
        filters: state.default.hair.filters ? state.default.hair.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(HairComponent);
