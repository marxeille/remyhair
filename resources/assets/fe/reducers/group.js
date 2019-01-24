import {RECEIVE_GROUPS} from "../actions/group";
const initState = {
    groups: {},
    item: {},
    permissions: {},
}
export default function group(state = initState, action) {
	switch (action.type) {
        case RECEIVE_GROUPS:
            return Object.assign({}, initState, {
                groups: action.data
            })
		default:
            return state;
	}
}
