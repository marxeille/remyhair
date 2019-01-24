import { combineReducers } from 'redux'
import env from './env'
import customer from './customer'
import dashboard from './dashboard'
import employee from './employee'
import history from './history'
import hair from './hair'
import sale from './sale'
import report from './report'
import support from './support'
import workProfile from './workProfile'
import group from './group'
import order from './order'
import saleCommission from './saleCommission'
import payment from './payment'
import invoice from './invoice'
import jobTitle from './jobTitle'

export default combineReducers({
    env,
    customer,
    dashboard,
    employee,
    history,
    hair,
    sale,
    report,
    support,
    workProfile,
    group,
    order,
    saleCommission,
    payment,
    invoice,
    jobTitle
})
