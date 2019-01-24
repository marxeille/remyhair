import { connect } from "react-redux"
import AddProcedure from "../../components/workprofile/addProcedure";

function mapStateToProps(state) {
    return {
       procedures: state.default.workProfile.procedures
    }
}

export default connect(mapStateToProps)(AddProcedure);
