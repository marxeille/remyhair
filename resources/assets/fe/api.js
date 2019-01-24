import superagent from "superagent";
const authInfo = localStorage.getItem('auth') ?  JSON.parse(localStorage.getItem('auth')) : null;
const jwt = authInfo ? authInfo.data.access_token : null;

export default {
    login(email, password) {
        let data = new FormData();
        data.append("email", email);
        data.append("password", password);
        return superagent.post('/api/auth/login').send(data);
    },

    initApp(jwt) {
        return superagent.post('/api/app/init').send({id_cart:localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getCustomerList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/customer/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getCustomerUnSupportList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/customer/un-support/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getCustomerListByEmployee(jwt, id_employee, page = 1, dataFilter = {}){
        let data = {
            "id_employee": id_employee,
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/employee/customers').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getSupportListByEmployee(jwt, id_employee, page = 1, dataFilter = {}){
        let data = {
            "id_employee": id_employee,
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };
        return superagent.post('/api/employee/supports').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    archiveWorkProfile(jwt, id){
        let data = {
            "id": id,
        };
        return superagent.post('/api/workprofile/archive').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    archiveOrder(jwt, id){
        let data = {
            "id": id,
        };
        return superagent.post('/api/order/archive').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getSaleCommissionList(jwt, dataFilter = {}){
        let data = {
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/sale-commission/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getDetailSaleCommissionList(jwt, id, page = 1, dataFilter = {}){
        let data = {
            "id": id,
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/sale-commission/get').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getWorkProfileDetail(jwt, id){
        let data = {
            "id": id,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/workprofile/get').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getCustomerListReport(page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/customer/report/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getOrderListReport(jwt, type, dataFilter = {}, dateShip = false){
        let data = {
            "jwt": jwt,
            "fields": dataFilter,
            "type": type,
            "date_ship": dateShip,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/order/report/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    sendWorkProfileComment(jwt, idWorkProfile, idEmployee, comment){
        let data = {
            "id_work_profile": idWorkProfile,
            "id_employee": idEmployee,
            "comment": comment,
            "id_cart": localStorage.getItem('idCart')
        };
        return superagent.post('/api/workprofile/comment/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeWorkProfileComment(jwt, id){
        let data = {
            "id": id,
            "id_cart": localStorage.getItem('idCart')
        };
        return superagent.post('/api/workprofile/comment/remove').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateWorkProfileComment(jwt, id, commment){
        let data = {
            "id": id,
            "comment": commment,
            "id_cart": localStorage.getItem('idCart')
        };
        return superagent.post('/api/workprofile/comment/update').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestExportCustomers(jwt, dataFilter = {}){
        let data = {
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/customer/report/export').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestExportOrders(jwt, dataFilter = {}){
        let data = {
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/order/report/export').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getWorkProfileList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/workprofile/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getOrderList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/order/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editState(jwt, states){
        states = states.map((state, index) => {
            return Object.assign(state, {
                number: index
            })
        });
        let data = {
            "states": states,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/order/state/update').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editOrder(jwt, editData){
        let data = {
            "editData" : editData,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/order/detail/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getWorkProfilesForKanban(jwt, dataFilter = {}){
        let data = {
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/workprofile/kanban').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getOrdersForKanban(jwt, dataFilter = {}){
        let data = {
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart'),
        };
        return superagent.post('/api/order/kanban').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addWorkProfile(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/workprofile/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editWorkProfile(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/workprofile/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getWorkProfile(jwt, id){
        return superagent.post('/api/workprofile/get').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getEmployeeList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };
        return superagent.post('/api/employee/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getHairList(jwt, page = 1, dataFilter = {}, kind){
        let data = {
            "page_number": page,
            "fields": dataFilter
        };
        return superagent.post('/api/hair/list/' + kind).send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },
    getPaymentList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter
        };
        return superagent.post('/api/payment/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },
    getJobTitleList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter
        };
        return superagent.post('/api/job-title/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getInvoiceList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter
        };
        return superagent.post('/api/invoice/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getSupportList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/support/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addGroup(jwt, data){
        return superagent.post('/api/group/add').send({
            'name': data.name,
            'permissions' : data.permissions,
            "id_cart": localStorage.getItem('idCart')
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },
    editGroup(jwt, id, data){
        return superagent.post('/api/group/edit').send({
            'id': id,
            'name': data.name,
            'permissions' : data.permissions,
            "id_cart": localStorage.getItem('idCart')
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateAddress(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/address/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getGroups(jwt){
        return superagent.post('/api/group/list').send({ "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getGroup(jwt, id){
        return superagent.post('/api/group/get').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeGroup(jwt, id){
        return superagent.post('/api/group/remove').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addCustomer(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/customer/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editCustomer(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/customer/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getCustomer(jwt, id){
        return superagent.post('/api/customer/get').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    detailCustomer(jwt, id){
        return superagent.post('/api/customer/detail').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    detailEmployee(jwt, id){
        return superagent.post('/api/employee/detail').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },
    detailSupport(jwt, id){
        return superagent.post('/api/support/detail').send({id: id, "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    refreshToken(jwt){
        return superagent.post('/api/auth/refresh').send({ "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getLeaders(jwt){
        return superagent.post('/api/employee/leader/get').send({ "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addEmployee(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/employee/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addHair(jwt, data, kind){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/add/hair/' + kind).send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addPayment(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/payment/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addJobTitle(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/job-title/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addInvoice(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/invoice/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getHair(jwt, id, kind){
        return superagent.post('/api/hair/get/' + kind + '/' + id).send({"id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getPayment(jwt, id){
        return superagent.post('/api/payment/get').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getJobTitle(jwt, id){
        return superagent.post('/api/job-title/get').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getInvoice(jwt, id){
        return superagent.post('/api/invoice/get').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editHair(jwt, data, kind){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/hair/edit/' + kind + '/' + data.id).send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editPayment(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/payment/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editJobTitle(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/job-title/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editInvoice(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/invoice/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getEmployee(jwt, id){
        return superagent.post('/api/employee/get').send({id: id,  "id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editEmployee(jwt, data){
        data.id_cart = localStorage.getItem('idCart');
        return superagent.post('/api/employee/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addSupport(jwt, data){
        return superagent.post('/api/support/add').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editSupport(jwt, data){
        return superagent.post('/api/support/edit').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getSupport(jwt, id){
        return superagent.post('/api/support/get').send({id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getHistoryList(jwt, page = 1, dataFilter = {}){
        let data = {
            "page_number": page,
            "fields": dataFilter,
            "id_cart": localStorage.getItem('idCart')
        };

        return superagent.post('/api/history/list').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestInitCart(jwt){
        let data = {
            "id_cart": localStorage.getItem('idCart'),
        };

        return superagent.post('/api/cart/init').send(data).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestAddProduct(jwt, data){
        return superagent.post('/api/cart/product').send({
            id_hair_size: data.id_hair_size,
            id_hair_type: data.id_hair_type,
            id_hair_color: data.id_hair_color,
            id_hair_draw: data.id_hair_draw,
            id_hair_style: data.id_hair_style,
            id_cart: data.id_cart,
            kg: data.kg,
            price: data.price,
            sub_action: 'add'
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateProduct(jwt, data){
        return superagent.post('/api/cart/product').send({
            id: data.id,
            id_hair_size: data.id_hair_size,
            id_hair_type: data.id_hair_type,
            id_hair_color: data.id_hair_color,
            id_hair_draw: data.id_hair_draw,
            id_hair_style: data.id_hair_style,
            id_cart: data.id_cart,
            kg: data.kg,
            price: data.price,
            sub_action: 'update'
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeProduct(jwt, data){
        return superagent.post('/api/cart/product').send({
            id: data.id,
            id_cart: data.id_cart,
            sub_action: 'remove'
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    searchCustomer(jwt, data){
        return superagent.post('/api/customer/search').send({
            "key_word": data,
            "id_cart": localStorage.getItem('idCart')
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deleteCustomer(jwt, id){
        return superagent.post('/api/customer/delete').send({
            "id": id,
            "id_cart": localStorage.getItem('idCart')
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateShippingCost(jwt, data){
        return superagent.post('/api/cart/shipping').send({
            "id_cart": data.id,
            "shipping_cost": data.shipping_cost
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateCarrier(jwt, data){
        return superagent.post('/api/cart/carrier').send({
            "id_cart": data.id,
            "id_carrier": data.id_carrier,
            "sub_action": 'update'
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateSaleman(jwt, data){
        return superagent.post('/api/cart/saleman').send({
            "id_cart": data.id,
            "id_employee": data.id_employee,
            "sub_action": 'update'
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateDiscount(jwt, data){
        return superagent.post('/api/cart/discount').send({
            "id_cart": data.id,
            "discount": data.discount,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updatePaymentFee(jwt, data){
        return superagent.post('/api/cart/payment-fee').send({
            "id_cart": data.id,
            "payment_fee": data.payment_fee,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    importProducts(jwt, data){
        return superagent.post('/api/cart/product').send({
            "id_cart": data.id,
            "products": data.products,
            "sub_action": 'import',
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    importCustomers(jwt, data){
        return superagent.post('/api/customer/import').send({
            "id_cart": data.id,
            "customers": data.customers,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateIdCustomer(jwt, data){
        return superagent.post('/api/cart/customer').send({
            "id_cart": data.id_cart,
            "id_customer": data.id,
            "sub_action": 'add',
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateIdAddress(jwt, data, idCart){
        return superagent.post('/api/cart/address').send({
            "id_cart": idCart,
            "id_address": data.id,
            "sub_action": 'update',
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeProcedureStep(jwt, id){
        return superagent.post('/api/workprofile/step/delete').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeOrderStates(jwt, id){
        return superagent.post('/api/order/state/delete').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getAddress(jwt, id){
        return superagent.post('/api/address/get').send({
            "id": id,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    clearCustomer(jwt, idCart){
        return superagent.post('/api/cart/customer').send({
            "id_cart": idCart,
            "sub_action": "remove"
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    clearAddress(jwt, idCart){
        return superagent.post('/api/cart/address').send({
            "id_cart": idCart,
            "sub_action": "remove"
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getProcedures(){
        return superagent.post('/api/procedure/list').send({
            "id_cart": localStorage.getItem('idCart'),
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addAddess(jwt, idCountry, idState, address, idCart){
        return superagent.post('/api/cart/address').send({
            "id_cart": idCart,
            "id_country": idCountry,
            "id_state": idState,
            "address": address,
            "sub_action": "add"
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addProcedure(procedure){
         procedure.steps = procedure.steps.map((step, index) => {
             return Object.assign(step, {
                 number: index
             })
         });
        return superagent.post('/api/procedure/add').send({
            "id_cart": localStorage.getItem('idCart'),
            "procedure": procedure
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    editProcedure(procedure){
         procedure.procedure_steps = procedure.procedure_steps.map((step, index) => {
             return Object.assign(step, {
                 number: index
             })
         });
        return superagent.post('/api/procedure/edit').send({
            "id_cart": localStorage.getItem('idCart'),
            "procedure": procedure
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getProcedure(jwt, id){
        return superagent.post('/api/procedure/get').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateWorkProfileState(jwt, workProfiles){
        return superagent.post('/api/workprofile/update').send({
            "id_cart": localStorage.getItem('idCart'),
            "workProfiles": workProfiles
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addLeaderSuggesstion(jwt, id, suggesstion){
        return superagent.post('/api/workprofile/suggesstion/update').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id,
            "suggesstion": suggesstion,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    updateOrderState(jwt, orders){
        return superagent.post('/api/order/states/update').send({
            "id_cart": localStorage.getItem('idCart'),
            "orders": orders
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    removeProcedure(jwt, id){
        return superagent.post('/api/procedure/remove').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestOrder(jwt, id){
        return superagent.post('/api/order/get').send({
            "id_cart": localStorage.getItem('idCart'),
            "id": id
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    completeOrder(jwt, order, editingOrder = null){
       const { id, id_carrier, id_customer, id_employee, id_address, shipping_cost, discount, note, img, date_ship, paid, id_payment, id_state, reason, payment_fee } = order;
        return superagent.post('/api/sale/validate').send({
            "id_cart": localStorage.getItem('idCart'),
            "balance": localStorage.getItem('cartCustomerBalance'),
            "id_carrier": id_carrier,
            "id_customer": id_customer,
            "id_employee": id_employee,
            "id_address": id_address,
            "shipping_cost": shipping_cost,
            "discount": discount,
            "note": note,
            "img": img,
            "date_ship": date_ship,
            "payment_fee": payment_fee,
            "reason": reason,
            "paid": paid,
            "id_payment": id_payment,
            "id_state": id_state,
            "sub_action": "validate",
            "editing_order": editingOrder
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deleteHair(jwt, id, kind) {
        return superagent.post('/api/hair/delete/' + kind + '/' + id).send({"id_cart": localStorage.getItem('idCart')}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deletePayment(jwt, id) {
        return superagent.post('/api/payment/delete').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deleteJobTitle(jwt, id) {
        return superagent.post('/api/job-title/delete').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deleteEmployee(jwt, id) {
        return superagent.post('/api/employee/delete').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    deleteInvoice(jwt, id) {
        return superagent.post('/api/invoice/delete').send({"id_cart": localStorage.getItem('idCart'), id: id}).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestChangeStateOrder(jwt, order) {
        order.id_state = order.current_status;
        return superagent.post('/api/order/state/change').send({
            "id_cart": localStorage.getItem('idCart'),
            "order": order
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestAddPaidOrder(jwt, order) {
        return superagent.post('/api/order/payment/add').send({
            "id_cart": localStorage.getItem('idCart'),
            "order": order
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    requestUpdateOrder(jwt, data) {
        return superagent.post('/api/order/update').send({
            "id_cart": localStorage.getItem('idCart'),
            "data": data
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    getDataDashBoard(jwt, range, summaryStartDate, startDate, endDate){
        return superagent.post('/api/dashboard/get').send({
            "granularity": range,
            "summary_start_date": summaryStartDate,
            "date_from":startDate,
            "date_to": endDate,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    sendEmail(data){
        return superagent.post('/api/workprofile/sendemail').send({
            "id_work_profile": data.work_profile.id,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    sendEmailChangeStatus(data){
        return superagent.post('/api/workprofile/sendemailchangestatus').send({
            "workProfiles": data,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    changeStatusEmployee(idEmployee, active){
        return superagent.post('/api/employee/status').send({
            "id": idEmployee,
            "active": active
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    initEditCart(data, jwt){
        return superagent.post('/api/order/cart/init').send({
            "id_order": data.idOrder,
            "id_cart": data.idCart,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    },

    addPaidOrder(data, jwt){
        return superagent.post('/api/order/paid/update').send({
            "id_order": data.idOrder,
            "new_paid": data.newPaid,
            "id_payment": data.payment,
        }).set({'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt});
    }
    
}
