import { connect } from "react-redux"
import ListSupport from "../../components/employee/listSupport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        supports: state.default.employee.supports.items ? state.default.employee.supports.items  : {},
        currentPage: state.default.employee.supports.currentPage ? state.default.employee.supports.currentPage : 1,
        pageLimit: state.default.employee.supports.pageLimit ? state.default.employee.supports.pageLimit : {},
        itemsPerPage: state.default.employee.supports.itemsPerPage ? state.default.employee.supports.itemsPerPage : 0,
        totalItems: state.default.employee.supports.totalItems ? state.default.employee.supports.totalItems : 0,
        isFetching:  state.default.employee.supports.isFetching,
        filters: state.default.employee.supports.filters ? state.default.employee.supports.filters : {},
        groups: state.default.env.groups,
        actions: state.default.env.actions,
        payments: state.default.env.payments ? state.default.env.payments : {},
        invoiceStatus: state.default.env.invoices_status ? state.default.env.invoices_status : {},
        support_status: state.default.env.support_status ? state.default.env.support_status : {},
    }
}

export default connect(mapStateToProps)(ListSupport);
