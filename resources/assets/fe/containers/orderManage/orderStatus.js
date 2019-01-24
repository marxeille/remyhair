import { connect } from "react-redux"
import OrderState from "../../components/order/orderState";

function mapStateToProps(state) {
    return {
       states: state.default.env.order_states,
        jwt: state.default.env.jwt,
    }
}

export default connect(mapStateToProps)(OrderState);
