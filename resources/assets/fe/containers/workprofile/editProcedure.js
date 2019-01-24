import { connect } from "react-redux"
import EditProcedure from "../../components/workprofile/editProcedure";

function mapStateToProps(state) {
    return {
       procedures: state.default.workProfile.procedures,
        jwt: state.default.env.jwt
    }
}

export default connect(mapStateToProps)(EditProcedure);
