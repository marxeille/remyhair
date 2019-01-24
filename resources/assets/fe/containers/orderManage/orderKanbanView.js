import { connect } from "react-redux"
import OrderKanbanView from "../../components/order/kanban";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        employee: state.default.env.employee,
        orders: state.default.order.kanban.orders,
        isFetching:  state.default.order.isFetching,
        kanbanData: state.default.order.kanbanData ? state.default.order.kanbanData : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(OrderKanbanView);
