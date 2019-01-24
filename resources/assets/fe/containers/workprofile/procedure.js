import { connect } from "react-redux"
import Procedure from "../../components/workprofile/procedure";

function mapStateToProps(state) {
    return {
       procedures: state.default.workProfile.procedures
    }
}

export default connect(mapStateToProps)(Procedure);
