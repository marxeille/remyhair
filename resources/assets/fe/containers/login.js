import { connect } from "react-redux"
import Login from '../components/login'

function mapStateToProps(state) {
    return {
        login: state.default.env.login,
        employee: state.default.env.employee,
        jwt: state.default.env.jwt,
        remember: state.default.env.rember,
        login_msg: state.default.env.msg,
    }
}

export default connect(mapStateToProps)(Login);
