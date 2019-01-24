export const GET_DATA = 'dashboard/GET_DATA';
export const RECEIVE_DASHBOARD = 'dashboard/RECEIVE_ADD_GROUP';

export function getData(jwt, range, summaryStartDate, startDate, endDate, onSuccess, onError){
  return {
    type: GET_DATA,
    jwt:jwt,
    range:range,
    summaryStartDate: summaryStartDate,
    startDate: startDate,
    endDate: endDate,
    onSuccess: onSuccess,
    onError: onError
  }
}

export function receiveDashboard( result, range){
    return {
        type: RECEIVE_DASHBOARD,
        data: result,
        range: range
    }
}
