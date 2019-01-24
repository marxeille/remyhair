import {
    RECEIVE_ADD_WORK_PROFILE,
    RECEIVE_LIST, RECEIVE_LIST_KANBAN, RECEIVE_ORDER, RECEIVE_ORDER_KANBAN,
    RECEIVE_PROCEDURES, RECEIVE_UPDATE_ORDER, REQUEST_ARCHIVE_ORDER,

} from "../actions/order";

const initState = {
    orders: {},
    filters: {},
    procedures: {},
    order: {},
    kanban:{
        orders:{},
        filters: {}
    }
};

export default function order(state = initState, action) {
	switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                orders: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters,
                kanbanData: action.data.kanbanData ? action.data.kanbanData : {}
            });
        }

        case RECEIVE_LIST_KANBAN: {
            return Object.assign({}, state, {
                kanban: {
                    orders: action.data.items,
                    filters: action.data.filters
                },
                kanbanData: action.data.kanbanData ? action.data.kanbanData : {}
            });
        }

        case REQUEST_ARCHIVE_ORDER: {
            return Object.assign({}, state, {
                kanban: Object.assign({}, state.kanban, {
                    orders: _.filter(state.kanban.orders, (wp) => wp.id != action.data)
                }),

                orders: _.filter(state.orders, (wp) => wp.id != action.data)
            });
        }

        case RECEIVE_ADD_WORK_PROFILE: {
            return Object.assign({}, state, {
                workProfiles: action.data,
            });
        }

        case RECEIVE_ORDER: {
            return Object.assign({}, state, {
                order: action.data,
            });
        }

        case RECEIVE_ORDER_KANBAN: {
            return Object.assign({}, state, {
                orders: action.data,
            });
        }

        case RECEIVE_UPDATE_ORDER: {
            let orders  = state.orders;
            orders = orders.map((item) => {
                return item.id == action.data.id ? Object.assign({}, item, action.data) : item;
            });
            return Object.assign({}, state, {
                orders: orders
            });
        }

        case RECEIVE_PROCEDURES: {
            return Object.assign({}, state, {
                procedures: action.data,
            });
        }

		default:
			return state;
	}
}
