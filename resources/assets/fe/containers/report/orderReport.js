import { connect } from "react-redux"
import OrderReport from "../../components/report/orderReport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orderStatus: state.default.env.order_status,
        hairStyles: state.default.env.hair_styles,
        hairSizes: state.default.env.hair_sizes,
        hairTypes: state.default.env.hair_types,
        orders: state.default.report.order.items ? state.default.report.order.items  : {},
        products: state.default.report.product.items ? state.default.report.product.items  : {},
        productFilters: state.default.report.product.filters ? state.default.report.product.filters  : {},
        closures: state.default.report.closure.items ? state.default.report.closure.items  : {},
        closureFilters: state.default.report.closure.filters ? state.default.report.closure.filters  : {},
        closureTypes: state.default.report.closure.closure_type ? state.default.report.closure.closure_type  : {},
        productPagination: state.default.report.product.pagination ? state.default.report.product.pagination  : {},
        weftTypes: state.default.report.product.weft_type ? state.default.report.product.weft_type  : {},
        currentPage: state.default.report.order.currentPage ? state.default.report.order.currentPage : {} ,
        pageLimit: state.default.report.order.pageLimit ? state.default.report.order.pageLimit : {},
        itemsPerPage: state.default.report.order.itemsPerPage ? state.default.report.order.itemsPerPage : {},
        totalItems: state.default.report.order.totalItems ? state.default.report.order.totalItems : {},
        isFetching:  state.default.report.order.isFetching,
        filters: state.default.report.order.filters ? state.default.report.order.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(OrderReport);
