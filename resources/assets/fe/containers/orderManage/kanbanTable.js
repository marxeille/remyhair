import { connect } from "react-redux"
import KanbanTable from "../../components/order/kanbanTable";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        employee: state.default.env.employee,
        items: state.default.order.kanban.orders,
        kanbanData: state.default.order.kanbanData ? state.default.order.kanbanData : {},
        filters: state.default.order.kanban.filters,
        env: state.default.env,
    }
}

export default connect(mapStateToProps)(KanbanTable);
