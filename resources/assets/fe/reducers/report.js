import {RECEIVE_LIST} from "../actions/report/customer";
import {
    RECEIVE_REPORT_PAYMENT,
    RECEIVE_ORDER_SUMMARY,
    RECEIVE_ORDER_STATS,
    RECEIVE_ORDER_WEFT,
    RECEIVE_ORDER_CLOSURE,
    RECEIVE_REPORT_TYPE,
    RECEIVE_REPORT_SIZE,
    RECEIVE_REPORT_COUNTRY,
    RECEIVE_REPORT_CUSTOMER, RECEIVE_REPORT_CUSTOMER_BALANCE
} from "../actions/report/order";

const initState = {
    customer: {
        items: {},
        filters: {}
    },
    order: {
        stats:{
            items: {},
            filter: {}
        },
        summary:{
            items: {},
            filter: {}
        },
        weft:{
            items: {},
            filter: {}
        },
        closure:{
            items: {},
            filter: {}
        },
        type:{
            items:{},
            filter:{}
        },
        size:{
            items:{},
            filter:{}
        },
        country:{
            items:{},
            filters:{}
        },
        customer:{
            items:{},
            filters:{}
        },
        customerBalance:{
            items:{},
            filters:{}
        },
        payment:{
            items:{},
            filters:{}
        },

    },
};


export default function report(state = initState, action) {

    switch (action.type) {
        case RECEIVE_LIST:{

           return Object.assign({}, state, {
               customer: {
                   items: action.data.items,
                   pageLimit: action.data.page_limit,
                   currentPage: action.data.current_page,
                   itemsPerPage: action.data.items_per_page,
                   totalItems: action.data.total_items,
                   filters: action.data.filters
               }
            });
        }

        case RECEIVE_ORDER_STATS:{
            return Object.assign({}, state, {
                order: Object.assign({}, state.order, {
                    stats: action.data
                })
             });
         }

         case RECEIVE_ORDER_SUMMARY:{
            return Object.assign({}, state, {
                order: Object.assign({}, state.order, {
                    summary: action.data
                })
             });
         }

         case RECEIVE_ORDER_WEFT:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     weft: action.data
                 })
             });
         }

         case RECEIVE_ORDER_CLOSURE:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     closure: action.data
                 })
             });
         }
         case RECEIVE_REPORT_TYPE:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     type: action.data
                 })
             });
         }
         case RECEIVE_REPORT_SIZE:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     size: action.data
                 })
             });
         }

         case RECEIVE_REPORT_COUNTRY:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     country: action.data
                 })
             });
         }
         case RECEIVE_REPORT_CUSTOMER:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     customer: action.data
                 })
             });
         }
         case RECEIVE_REPORT_CUSTOMER_BALANCE:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     customerBalance: action.data
                 })
             });
         }
         case RECEIVE_REPORT_PAYMENT:{
             return Object.assign({}, state, {
                 order: Object.assign({}, state.order, {
                     payment: action.data
                 })
             });
         }

        default:
            return state;
    }
}
