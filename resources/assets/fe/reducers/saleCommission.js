import {RECEIVE_DETAIL_LIST, RECEIVE_LIST} from "../actions/saleCommission";

const initState = {
    saleCommissions: {},
    filters: {},
    detailSaleCommissions:{
        filters: {},
    }
};

export default function saleCommission(state = initState, action) {

	switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                saleCommissions: action.data.items,
                filters: action.data.filters
            });
        }

        case RECEIVE_DETAIL_LIST: {
            return Object.assign({}, state, {
                detailSaleCommissions: Object.assign({}, state.detailSaleCommissions, {
                    saleCommissions: action.data.items,
                    pageLimit: action.data.page_limit,
                    currentPage: action.data.current_page,
                    itemsPerPage: action.data.items_per_page,
                    totalItems: action.data.total_items,
                    filters: action.data.filters
                })
            });
        }

		default:
			return state;
	}
}
