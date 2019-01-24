import { connect } from "react-redux"
import App from '../components/app'

function mapStateToProps(state) {
    return {
        employee: state.default.env.employee,
        actions: state.default.env.actions,
        isInited:  state.default.env.isInited ? true : false
    }
}

export default connect(mapStateToProps)(App);
