import { connect } from "react-redux"
import HairComponent from '../../components/hair/hair'
import Invoice from "../../components/invoice/invoice";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        invoices: state.default.invoice.invoices,
        currentPage: state.default.invoice.currentPage ? state.default.invoice.currentPage : {} ,
        pageLimit: state.default.invoice.pageLimit ? state.default.invoice.pageLimit : {},
        itemsPerPage: state.default.invoice.itemsPerPage ? state.default.invoice.itemsPerPage : {},
        totalItems: state.default.invoice.totalItems ? state.default.invoice.totalItems : {},
        isFetching:  state.default.invoice.isFetching,
        filters: state.default.invoice.filters ? state.default.invoice.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(Invoice);
