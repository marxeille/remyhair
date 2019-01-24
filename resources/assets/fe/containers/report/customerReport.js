import { connect } from "react-redux"
import CustomerReport from "../../components/report/customerReport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        customers: state.default.report.customer.items ? state.default.report.customer.items  : {},
        currentPage: state.default.report.customer.currentPage ? state.default.report.customer.currentPage : {} ,
        pageLimit: state.default.report.customer.pageLimit ? state.default.report.customer.pageLimit : {},
        itemsPerPage: state.default.report.customer.itemsPerPage ? state.default.report.customer.itemsPerPage : {},
        totalItems: state.default.report.customer.totalItems ? state.default.report.customer.totalItems : {},
        isFetching:  state.default.report.customer.isFetching,
        filters: state.default.report.customer.filters ? state.default.report.customer.filters : {},
    }
}

export default connect(mapStateToProps)(CustomerReport);
