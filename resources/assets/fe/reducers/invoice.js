import {RECEIVE_INVOICE, RECEIVE_LIST, RECEIVE_NEW_INVOICE,} from "../actions/invoice";

const initState = {
    invoices: {},
    invoice:{},
    filters: {},
};
export default function invoice(state = initState, action) {
    
    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                invoices: action.data.data.items,
                pageLimit: action.data.data.page_limit,
                currentPage: action.data.data.current_page,
                itemsPerPage: action.data.data.items_per_page,
                totalItems: action.data.data.total_items,
                filters: action.data.data.filters
            });
        }

        case RECEIVE_INVOICE:{
            return Object.assign({}, state, {
                invoice: action.data
            })
        }

        case RECEIVE_NEW_INVOICE:{
            return Object.assign({}, state, {
                invoices: action.data
            });
       }

        default:
            return state;
    }
}
