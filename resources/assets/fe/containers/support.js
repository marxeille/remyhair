import { connect } from "react-redux"
import Support from "../components/support/support";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        supports: state.default.support.supports ? state.default.support.supports  : {},
        currentPage: state.default.support.currentPage ? state.default.support.currentPage : {} ,
        pageLimit: state.default.support.pageLimit ? state.default.support.pageLimit : {},
        itemsPerPage: state.default.support.itemsPerPage ? state.default.support.itemsPerPage : {},
        totalItems: state.default.support.totalItems ? state.default.support.totalItems : {},
        isFetching:  state.default.support.isFetching,
        filters: state.default.support.filters ? state.default.support.filters : {},
        payments: state.default.env.payments ? state.default.env.payments : {},
        invoiceStatus: state.default.env.invoices_status ? state.default.env.invoices_status : {},
        actions: state.default.env.actions,
        support_status: state.default.env.support_status ? state.default.env.support_status : {},
        customer_types: state.default.env.customer_type ? state.default.env.customer_type : {},
    }
}

export default connect(mapStateToProps)(Support);
