import {RECEIVE_LIST} from "../actions/history";

const initState = {
    histories: {},
    filters: {},
}
export default function history(state = initState, action) {
    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                history: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
        }

        default:
            return state;
    }
}
