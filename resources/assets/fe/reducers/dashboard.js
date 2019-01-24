import { RECEIVE_DASHBOARD } from "../actions/dashboard";
import Lodash from 'lodash';

const initialState = {
	day: {},
	week: {},
	month: {}
  }
  
export default function dashboard(state = initialState, action) {	
	switch (action.type) {
		case RECEIVE_DASHBOARD:
			return Lodash.assign({}, state, {[action.range]: action.data});
		default: 
			return state;
	}
}