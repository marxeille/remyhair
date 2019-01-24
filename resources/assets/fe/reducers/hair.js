import {RECEIVE_LIST, RECEIVE_NEW_HAIR, RECEIVE_DEL_HAIR, RECEIVE_HAIR} from "../actions/hair";

const initState = {
    hairs: {},
    hair:{},
    filters: {},
}
export default function hair(state = initState, action) {
    
    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                hairs: action.data.data.items,
                pageLimit: action.data.data.page_limit,
                currentPage: action.data.data.current_page,
                itemsPerPage: action.data.data.items_per_page,
                totalItems: action.data.data.total_items,
                filters: action.data.data.filters
            });
        }

        case RECEIVE_HAIR:{
            return Object.assign({}, state, {
                hair: action.data
            })
        }

        case RECEIVE_NEW_HAIR:{
            return Object.assign({}, state, {
                hairs: action.data.data
            });
        }

        case RECEIVE_DEL_HAIR: {
            return Object.assign({}, state, {
                hairs: action.data,
            });
        }

        default:
            return state;
    }
}
