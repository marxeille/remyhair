import { connect } from "react-redux"
import AddSupport from "../components/addSupport";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt
    }
}

export default connect(mapStateToProps)(AddSupport);
