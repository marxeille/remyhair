import { connect } from "react-redux"
import DetailCustomer from '../../components/customer/detailCustomer'

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(DetailCustomer);
