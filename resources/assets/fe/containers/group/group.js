import { connect } from "react-redux"
import Group from '../../components/group/group'

function mapStateToProps(state) {
    return {
        permission: state.default.group.permissions ? state.default.group.permissions : {},
        groups: state.default.group.groups ? state.default.group.groups : {} ,
        group: state.default.group.item ?  state.default.group.item : {},
        actions: state.default.env.actions ?  state.default.env.actions : {},
        jwt: state.default.env.jwt ?  state.default.env.jwt : {},
    }
}

export default connect(mapStateToProps)(Group);
