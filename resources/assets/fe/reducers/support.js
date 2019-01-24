import {RECEIVE_LIST} from "../actions/support";

const initState = {
    isFetching: true,

}
export default function support(state = initState, action) {

    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                supports: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                isFetching: false,
                filters: action.data.filters
            });

            break;
        }

        default:
            return state;
    }
}



