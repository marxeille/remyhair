import {LOGIN_SUCCESS, LOGOUT_SUCCESS, RECEIVE_INIT_APP, RECEIVE_LOGIN_INFO, RECEIVE_NEW_TOKEN} from "../actions/env";

const auth = JSON.parse(localStorage.getItem('auth'));
const initialState = {
    employee: auth !== null ? auth.data.employee : {},
    jwt: auth !== null ? auth.data.access_token : '',
    remember: false
}

export default function env(state = initialState, action) {
	switch (action.type) {
        case RECEIVE_LOGIN_INFO:{
            return Object.assign({}, state, {
                login: action.login,
                employee: action.employee,
                jwt: action.jwt,
                msg: action.message,
            });

            break;
        }

        case LOGIN_SUCCESS:{
            return Object.assign({}, state, {
                login: action.login,
                employee: action.employee,
                jwt: action.jwt,
            });

            break;
        }

        case LOGOUT_SUCCESS:{
            return Object.assign({}, state, {
                login: false,
                employee: {},
                jwt:'',
            });

            break;
        }

        case RECEIVE_INIT_APP:{
            localStorage.setItem('idCart', action.data.cart.id);
            return Object.assign({}, state, action.data);
            break;
        }

		default:
			return state;
	}
}
