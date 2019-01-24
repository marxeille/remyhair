import React, {Component} from 'react'
import { Switch, Route } from 'react-router-dom'
import Dashboard from "./containers/dashboard";
import Customer from "./containers/customer/customer";
import Employee from "./containers/employee/employee";
import Support from "./containers/support";
import Login from "./containers/login";
import Order from "./containers/orderManage/order";
import History from "./containers/history";
import Group from "./containers/group/group";
import WorkProfile from "./containers/workprofile/workprofile";
import AddWorkProfile from "./containers/workprofile/addWorkProfile";
import EditWorkProfile from "./containers/workprofile/editWorkProfile";
import AddGroup from "./containers/group/addGroup";
import EditGroup from "./containers/group/editGroup";
import AddCustomer from "./containers/customer/addCustomer";
import EditCustomer from "./containers/customer/editCustomer";
import DetailCustomer from "./containers/customer/detailCustomer";
import AddEmployee from "./containers/employee/addEmployee";
import EditEmployee from "./containers/employee/editEmployee";
import ListCustomer from "./containers/employee/listCustomer";
import AddSupport from "./containers/support/addSupport";
import EditSupport from "./containers/support/editSupport";
import CustomerReport from "./containers/report/customerReport";
import HairComponent from "./containers/hair/hair";
import Payment from "./containers/payment/payment";
import Invoice from "./containers/invoice/invoice";
import AddHair from "./containers/hair/addHair";
import EditHair from "./containers/hair/editHair";
import Procedure from "./containers/workprofile/procedure";
import AddProcedure from "./containers/workprofile/addProcedure";
import EditProcedureForKanban from "./containers/workprofile/editProcedureForKanban";
import WorkProfileKanbanView from "./containers/workprofile/workProfileKanbanView";
import Sale from "./containers/sale";
import OrderDetail from "./containers/orderManage/orderDetail";
import DetailEmployee from "./containers/employee/detailEmployee";
import DetailSupport from "./containers/support/detailSupport";
import OrderState from "./containers/orderManage/orderStatus";
import OrderKanbanView from "./containers/orderManage/orderKanbanView";
import SaleCommission from "./containers/saleCommission/saleCommission";
import DetailSaleCommission from "./containers/saleCommission/detail";
import AddEmployeeFamily from "./containers/employee/addEmployeeFamily";
import EditPayment from "./containers/payment/editPayment";
import EditInvoice from "./containers/invoice/editInvoice";
import AddPayment from "./containers/payment/addPayment";
import AddInvoice from "./containers/invoice/addInvoice";
import UnSupport from "./containers/customer/unsupport";
import ListSupport from "./containers/employee/listSupport";
import JobTitle from "./containers/jobTitle/jobTitle";
import EditJobTitle from "./containers/jobTitle/editJobTitle";
import AddJobTitle from "./containers/jobTitle/addJobTitle";
import OrderStats from "./containers/report/order/orderStats";
import OrderSummary from "./containers/report/order/orderSummary";
import OrderWeft from "./containers/report/order/orderWeft";
import Type from "./containers/report/order/type";
import Size from "./containers/report/order/size";
import Country from "./containers/report/order/country";
import OrderClosure from "./containers/report/order/orderClosure";
import OrderCustomerReport from "./containers/report/order/orderCustomerReport";
import CustomerBalance from "./containers/report/order/customerBalance";
import OrderPaymentReport from "./containers/report/order/orderPaymentReport";

export default class RouterPath extends Component{
    constructor(props){
        super(props);
    }
    render(){
        return (
            <Switch>
                <Route exact path={'/'} component={Dashboard}/>
                <Route exact path={'/customer'} component={Customer}/>
                <Route exact path={'/unsupport'} component={UnSupport}/>
                <Route exact path={'/employee'} component={Employee}/>
                <Route path={'/employee/add'} component={AddEmployee}/>
                <Route path={'/employee/detail/addfamily/:id?'} component={AddEmployeeFamily}/>
                <Route path={'/employee/detail/:id?'} component={DetailEmployee}/>
                <Route path={'/employee/customers/:id?'} component={ListCustomer}/>
                <Route path={'/employee/supports/:id?'} component={ListSupport}/>
                <Route exact path={'/support'} component={Support}/>
                <Route path={'/support/add'} component={AddSupport}/>
                <Route path={'/add/support/:id?'} component={AddSupport}/>
                <Route path={'/support/edit/:id?'} component={EditSupport}/>
                <Route path={'/support/detail/:id?'} component={DetailSupport}/>
                <Route path={'/sale'} component={Sale}/>
                <Route path={'/history'} component={History}/>
                <Route exact path={'/work-profile'} component={WorkProfile}/>
                <Route exact path={'/work-profile/kanban'} component={WorkProfileKanbanView}/>
                <Route exact path={'/order/kanban'} component={OrderKanbanView}/>
                <Route path={'/work-profile/add'} component={AddWorkProfile}/>
                <Route path={'/work-profile/edit/:id?'} component={EditWorkProfile}/>
                <Route path={'/work-profile'} component={WorkProfile}/>
                <Route path={'/login'} component={Login}/>
                <Route exact  path={'/group/'} component={Group}/>
                <Route path={'/group/add'} component={AddGroup}/>
                <Route path={'/group/edit/:id?'} component={EditGroup}/>
                <Route path={'/support/add'} component={AddSupport}/>
                <Route path={'/customer/add'} component={AddCustomer}/>
                <Route path={'/support/customer/add'} component={AddCustomer}/>
                <Route path={'/customer/edit/:id?'} component={EditCustomer}/>
                <Route path={'/customer/detail/:id?'} component={DetailCustomer}/>
                <Route path={'/employee/edit/:id?'} component={EditEmployee}/>
                <Route exact path={'/report/customer'} component={CustomerReport}/>
                <Route exact path={'/report/order/stats'} component={OrderStats}/>
                <Route exact path={'/report/order/summary'} component={OrderSummary}/>
                <Route exact path={'/report/order/type'} component={Type}/>
                <Route exact path={'/report/order/size'} component={Size}/>
                <Route exact path={'/report/order/country'} component={Country}/>
                <Route exact path={'/report/order/payment'} component={OrderPaymentReport}/>
                <Route exact path={'/report/order/customer'} component={OrderCustomerReport}/>
                <Route exact path={'/report/balance'} component={CustomerBalance}/>
                <Route exact path={'/report/order/weft'} component={OrderWeft}/>
                <Route exact path={'/report/order/closure'} component={OrderClosure}/>
                <Route exact path="/hair/list/:type" component={HairComponent} />
                <Route exact path="/add/hair/:type" component={AddHair} />
                <Route exact path="/edit/hair/:type/:id" component={EditHair} />
                <Route exact path={'/procedure'} component={Procedure}/>
                <Route exact path={'/order-states'} component={OrderState}/>
                <Route exact path={'/procedure/add'} component={AddProcedure}/>
                <Route exact path={'/procedure/:id?'} component={EditProcedureForKanban}/>
                <Route exact path={'/order'} component={Order}/>
                <Route exact path={'/order/:id?'} component={OrderDetail}/>
                <Route exact path={'/report/sale-commission'} component={SaleCommission}/>
                <Route exact path={'/report/sale-commission/:id'} component={DetailSaleCommission}/>
                <Route exact path={'/payment'} component={Payment}/>
                <Route exact path={'/payment/edit/:id?'} component={EditPayment}/>
                <Route exact path={'/payment/add'} component={AddPayment}/>
                <Route exact path={'/job-title'} component={JobTitle}/>
                <Route exact path={'/job-title/edit/:id?'} component={EditJobTitle}/>
                <Route exact path={'/job-title/add'} component={AddJobTitle}/>
                <Route exact path={'/invoice'} component={Invoice}/>
                <Route exact path={'/invoice/edit/:id?'} component={EditInvoice}/>
                <Route exact path={'/invoice/add'} component={AddInvoice}/>
            </Switch>
        )
    }
}
