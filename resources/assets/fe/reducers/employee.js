import {
    RECEIVE_EMPLOYEE,
    RECEIVE_LEADERS,
    RECEIVE_LIST,
    RECEIVE_LIST_CUSTOMER,
    RECEIVE_LIST_SUPPORT,
    RECEIVE_NEW_EMPLOYEE
} from "../actions/employee";

const initState = {
    employees: {},
    customers: {},
    supports: {},
    filters: {},
    employee:{}
}

export default function employee(state = initState, action) {
    switch (action.type) {
        case RECEIVE_LEADERS:{
            return Object.assign({}, state, {
                leaders: action.data
            })
        }

        case RECEIVE_EMPLOYEE:{
            return Object.assign({}, state, {
                employee: action.data
            })
        }

        case RECEIVE_NEW_EMPLOYEE:{
            return Object.assign({}, state, {
                employees: action.data
            });
        }

        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                employees: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
        }

        case RECEIVE_LIST_CUSTOMER: {
            let customers = state.customers;
            customers = Object.assign({}, customers, {
                items: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
            return Object.assign({}, state, {
                customers: customers
            });
        }

        case RECEIVE_LIST_SUPPORT: {
            let supports = state.supports;
            supports = Object.assign({}, supports, {
                items: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters
            });
            return Object.assign({}, state, {
                supports: supports
            });
        }

        default:
            return state;
    }
}
