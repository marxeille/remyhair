import { connect } from "react-redux"
import EditProcedureForkanban from "../../components/workprofile/editProcedureForKanban";

function mapStateToProps(state) {
    return {
       procedures: state.default.workProfile.procedures,
        jwt: state.default.env.jwt
    }
}

export default connect(mapStateToProps)(EditProcedureForkanban);
