import { connect } from "react-redux"
import EditGroup from "../../components/group/editGroup";

function mapStateToProps(state) {
    return {
        permissions: state.default.env.permissions ?  state.default.env.permissions : {},
        jwt: state.default.env.jwt
    }
}

export default connect(mapStateToProps)(EditGroup);
