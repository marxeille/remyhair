import { connect } from "react-redux"
import Customer from '../../components/customer/customer'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        customers: state.default.customer.customers ? state.default.customer.customers  : {},
        currentPage: state.default.customer.currentPage ? state.default.customer.currentPage : {} ,
        pageLimit: state.default.customer.pageLimit ? state.default.customer.pageLimit : {},
        itemsPerPage: state.default.customer.itemsPerPage ? state.default.customer.itemsPerPage : {},
        totalItems: state.default.customer.totalItems ? state.default.customer.totalItems : {},
        isFetching:  state.default.customer.isFetching,
        filters: state.default.customer.filters ? state.default.customer.filters : {},
        actions: state.default.env.actions,
        initData: state.default.sale.initData
    }
}

export default connect(mapStateToProps)(Customer);
