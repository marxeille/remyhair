import {
    RECEIVE_ADD_WORK_PROFILE,
    RECEIVE_LIST,
    RECEIVE_PROCEDURES,
    RECEIVE_WORKPROFILE_KANBAN,
    RECEIVE_LEADER_SUGGESSTION, RECEIVE_ARCHIVE_WORKPROFILE, RECEIVE_KANBAN_LIST
} from "../actions/workprofile";

const initState = {
    workProfiles: {},
    filters: {},
    procedures: {},
    kanban: {
        workProfile: {},
        filters: {}
    }
};

export default function workProfile(state = initState, action) {
	switch (action.type) {
        case RECEIVE_LIST: {
            return Object.assign({}, state, {
                workProfiles: action.data.items,
                pageLimit: action.data.page_limit,
                currentPage: action.data.current_page,
                itemsPerPage: action.data.items_per_page,
                totalItems: action.data.total_items,
                filters: action.data.filters,
                kanbanData: action.data.kanbanData ? action.data.kanbanData : {}
            });
        }

        case RECEIVE_KANBAN_LIST: {
            return Object.assign({}, state, {
                kanban:{
                    workProfile: action.data.items,
                    filters: action.data.filters
                },
                kanbanData: action.data.kanbanData ? action.data.kanbanData : {}
            });
        }

        case RECEIVE_ADD_WORK_PROFILE: {
            return Object.assign({}, state, {
                workProfiles: action.data,
            });
        }

        case RECEIVE_WORKPROFILE_KANBAN: {
            return Object.assign({}, state, {
                kanban:{
                    workProfile: action.data
                }
            });
        }

        case RECEIVE_ARCHIVE_WORKPROFILE: {
            return Object.assign({}, state, {
                kanban: Object.assign({}, state.kanban, {
                    workProfile: _.filter(state.kanban.workProfile, (wp) => wp.id != action.data)
                }),
                workProfiles: _.filter(state.workProfiles, (wp) => wp.id != action.data)
            });
        }
        case RECEIVE_LEADER_SUGGESSTION: {
            let workProfiles  = state.workProfiles;
            workProfiles = workProfiles.map((item) => {
                return item.id == action.data.id ? Object.assign({}, item, {
                    leader_suggesstion: action.data.suggesstion
                }) : item;
            });
            return Object.assign({}, state, {
                workProfiles: workProfiles,
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
