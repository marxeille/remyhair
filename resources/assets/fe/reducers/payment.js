import {RECEIVE_LIST, RECEIVE_NEW_PAYMENT, RECEIVE_PAYMENT} from "../actions/payment";

const initState = {
    payments: {},
    payment:{},
    filters: {},
};
export default function payment(state = initState, action) {
    
    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                payments: action.data.data.items,
                pageLimit: action.data.data.page_limit,
                currentPage: action.data.data.current_page,
                itemsPerPage: action.data.data.items_per_page,
                totalItems: action.data.data.total_items,
                filters: action.data.data.filters
            });
        }

        case RECEIVE_PAYMENT:{
            return Object.assign({}, state, {
                payment: action.data
            })
        }

        case RECEIVE_NEW_PAYMENT:{
            return Object.assign({}, state, {
                payments: action.data
            });
    }
        default:
            return state;
    }
}
