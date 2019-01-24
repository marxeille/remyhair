import { connect } from "react-redux"
import UnSupport from '../../components/customer/unsupport'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        customers: state.default.customer.unsupport.customers ? state.default.customer.unsupport.customers  : {},
        currentPage: state.default.customer.unsupport.currentPage ? state.default.customer.unsupport.currentPage : {} ,
        pageLimit: state.default.customer.unsupport.pageLimit ? state.default.customer.unsupport.pageLimit : {},
        itemsPerPage: state.default.customer.unsupport.itemsPerPage ? state.default.customer.unsupport.itemsPerPage : {},
        totalItems: state.default.customer.unsupport.totalItems ? state.default.customer.unsupport.totalItems : {},
        isFetching:  state.default.customer.unsupport.isFetching,
        filters: state.default.customer.unsupport.filters ? state.default.customer.unsupport.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(UnSupport);
