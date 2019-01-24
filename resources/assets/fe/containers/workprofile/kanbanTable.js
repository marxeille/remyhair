import { connect } from "react-redux"
import WorkProfileKanbanView from "../../components/workprofile/kanban";
import KanbanTable from "../../components/workprofile/kanbanTable";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        items: state.default.workProfile.kanban.workProfile,
        kanbanData: state.default.workProfile.kanbanData ? state.default.workProfile.kanbanData : {},
        filters: state.default.workProfile.kanban.filters,
        employee: state.default.env.employee
    }
}

export default connect(mapStateToProps)(KanbanTable);
