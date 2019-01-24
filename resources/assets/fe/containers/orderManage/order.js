import { connect } from "react-redux"
import Order from "../../components/order/order";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        orders: state.default.order.orders,
        currentPage: state.default.order.currentPage ? state.default.order.currentPage : {} ,
        pageLimit: state.default.order.pageLimit ? state.default.order.pageLimit : {},
        itemsPerPage: state.default.order.itemsPerPage ? state.default.order.itemsPerPage : {},
        totalItems: state.default.order.totalItems ? state.default.order.totalItems : {},
        isFetching:  state.default.order.isFetching,
        filters: state.default.order.filters ? state.default.order.filters : {},
        actions: state.default.env.actions,
        payments: state.default.env.payments,
        order_status: state.default.env.order_status,
        employees: state.default.env.employees,
    }
}

export default connect(mapStateToProps)(Order);
