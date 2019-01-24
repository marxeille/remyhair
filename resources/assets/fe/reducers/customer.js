import {RECEIVE_ADD_CUSTOMER, RECEIVE_LIST, RECEIVE_UNSUPPORT_LIST, RECEIVE_DELETE_CUSTOMER} from "../actions/customer";

const initState = {
    customers: {},
    filters: {},
    unsupport:{
    }
}

export default function customer(state = initState, action) {

	switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                customers: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
        }

        case RECEIVE_DELETE_CUSTOMER: {
            return Object.assign({}, state, {
                customers: _.filter(state.customers, (customer) => customer.id != action.data.id)
            });
        }

        case RECEIVE_UNSUPPORT_LIST: {
            let unsupport = state;
            unsupport = Object.assign({}, state, {
                customers: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
            return Object.assign({}, state, {
                unsupport: unsupport
            })
        }

        case RECEIVE_ADD_CUSTOMER: {
            return Object.assign({}, state, {
                customers: action.data,
            });
        }

		default:
			return state;
	}
}
