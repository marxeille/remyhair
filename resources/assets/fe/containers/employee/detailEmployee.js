import { connect } from "react-redux"
import DetailEmployee from '../../components/employee/detailEmployee'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(DetailEmployee);
