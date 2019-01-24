import {RECEIVE_LIST, RECEIVE_NEW_JOBTITLE, RECEIVE_JOBTITLE} from "../actions/jobTitle";

const initState = {
    jobTitles: {},
    jobTitle:{},
    filters: {},
};
export default function jobTitle(state = initState, action) {
    
    switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                jobTitles: action.data.data.items,
                pageLimit: action.data.data.page_limit,
                currentPage: action.data.data.current_page,
                itemsPerPage: action.data.data.items_per_page,
                totalItems: action.data.data.total_items,
                filters: action.data.data.filters
            });
        }

        case RECEIVE_JOBTITLE:{
            return Object.assign({}, state, {
                jobTitle: action.data
            })
        }

        case RECEIVE_NEW_JOBTITLE:{
            return Object.assign({}, state, {
                jobTitles: action.data
            });
    }
        default:
            return state;
    }
}
