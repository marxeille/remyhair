import { connect } from "react-redux"
import Dashboard from '../components/dashboard'

function mapStateToProps(state) {
    return {
        dashboardData: state.default.dashboard,
        jwt: state.default.env.jwt,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(Dashboard);
