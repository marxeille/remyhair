import { connect } from "react-redux"
import AddGroup from "../../components/group/addGroup";

function mapStateToProps(state) {
    return {
        permissions: state.default.env.permissions ?  state.default.env.permissions : {},
        jwt: state.default.env.jwt
    }
}

export default connect(mapStateToProps)(AddGroup);
