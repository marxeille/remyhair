import { connect } from "react-redux"
import DetailSupport from '../../components/support/detailSupport'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(DetailSupport);
