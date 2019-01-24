<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/auth/login', 'AuthController@login');
Route::post('/auth/refresh', ['middleware' => 'jwt.refresh', 'uses' =>  'AuthController@refreshToken']);


// All request must has access token
Route::group(['middleware' => 'remy.permission'], function () {
    Route::post('/customer/list', 'CustomerController@renderList');
    Route::post('/customer/un-support/list', 'CustomerController@renderListUnSupport');
    Route::post('/customer/add', 'CustomerController@add');
    Route::post('/customer/edit', 'CustomerController@edit')->middleware('history.save');
    Route::post('/customer/get', 'CustomerController@get');
    Route::post('/customer/detail', 'CustomerController@detail');
    Route::post('/customer/delete', 'CustomerController@delete')->middleware('history.save');
    Route::post('/payment/list', 'PaymentController@renderList');
    Route::post('/payment/add', 'PaymentController@add');
    Route::post('/payment/edit', 'PaymentController@edit')->middleware('history.save');
    Route::post('/payment/get', 'PaymentController@get');
    Route::post('/payment/delete', 'PaymentController@delete')->middleware('history.save');
    Route::post('/job-title/list', 'JobTitleController@renderList');
    Route::post('/job-title/add', 'JobTitleController@add');
    Route::post('/job-title/edit', 'JobTitleController@edit')->middleware('history.save');
    Route::post('/job-title/get', 'JobTitleController@get');
    Route::post('/job-title/delete', 'JobTitleController@delete')->middleware('history.save');
    Route::post('/invoice/list', 'InvoiceController@renderList');
    Route::post('/invoice/add', 'InvoiceController@add');
    Route::post('/invoice/edit', 'InvoiceController@edit')->middleware('history.save');
    Route::post('/invoice/get', 'InvoiceController@get');
    Route::post('/invoice/delete', 'InvoiceController@delete')->middleware('history.save');
    Route::post('/customer/report/list', 'CustomerController@reportList');
    Route::post('/customer/report/export', 'CustomerController@exportList');
    Route::post('/employee/list', 'EmployeeController@renderList');
    Route::post('/employee/add', 'EmployeeController@add');
    Route::post('/employee/edit', 'EmployeeController@edit')->middleware('history.save');
    Route::post('/employee/customers', 'CustomerController@renderListById');
    Route::post('/employee/supports', 'SupportController@renderListById');
    Route::post('/employee/delete', 'EmployeeController@delete')->middleware('history.save');
    Route::post('/employee/detail', 'EmployeeController@detail');
    Route::post('/employee/status', 'EmployeeController@ChangeStatus');
    Route::post('/support/list', 'SupportController@renderList');
    Route::post('/group/list', 'GroupController@responseList');
    Route::post('/group/edit', 'GroupController@edit')->middleware('history.save');
    Route::post('/group/get', 'GroupController@get');
    Route::post('/group/remove', 'GroupController@remove')->middleware('history.save');
    Route::group(['middleware' => 'workprofile.modify'], function () {
        Route::post('/workprofile/edit', 'WorkProfileController@edit');
        Route::post('/workprofile/delete', 'WorkProfileController@delete');
    });
    Route::post('/support/add',['as'=>'support.add','uses'=>'SupportController@add']);
    Route::post('/support/edit', ['as'=>'support.add','uses'=>'SupportController@edit'])->middleware('history.save');
    Route::post('/support/detail', 'SupportController@detail');

    Route::post('/address/edit',['as'=>'customer.address.edit','uses'=>'CustomerController@EditAddress']);
    Route::post('/employee/leader/get',['as'=>'employee.leader.get','uses'=>'EmployeeController@GetLeader']);
    Route::post('/employee/get',['as'=>'employee.get','uses'=>'EmployeeController@get']);
    Route::post('/employeeFamily/add',['as'=>'employee.get','uses'=>'EmployeeController@addFamily']);
    // Work profile
    Route::post('/workprofile/sendemail', 'WorkProfileController@sendemail');
    Route::post('/workprofile/sendemailchangestatus', 'WorkProfileController@sendEmailChangeStatus');
    Route::post('/workprofile/add', 'WorkProfileController@add');
    Route::post('/workprofile/get', 'WorkProfileController@get');
    Route::post('/procedure/list', 'WorkProfileController@getListProcedures');
    Route::post('/procedure/add', 'WorkProfileController@addProcedure');
    Route::post('/procedure/get', 'WorkProfileController@getProcedure');
    Route::post('/procedure/remove', 'WorkProfileController@removeProcedure')->middleware('history.save');
    Route::post('/procedure/edit', 'WorkProfileController@editProcedure')->middleware('history.save');
    Route::post('/workprofile/update', 'WorkProfileController@updateState');
    Route::post('/workprofile/comment/add', 'WorkProfileController@addComment');
    Route::post('/workprofile/comment/update', 'WorkProfileController@updateComment');
    Route::post('/workprofile/comment/remove', 'WorkProfileController@removeComment');
    Route::post('/workprofile/archive', 'WorkProfileController@archive');
    Route::group(['middleware' => 'workprofile.modify'], function () {
        Route::post('/workprofile/edit', 'WorkProfileController@edit')->middleware('history.save');
        Route::post('/workprofile/delete', 'WorkProfileController@delete')->middleware('history.save');
        Route::post('/workprofile/suggesstion/update', 'WorkProfileController@updateSuggesstion')->middleware('history.save');

    });
    Route::post('/workprofile/list', 'WorkProfileController@renderList');
    Route::post('/workprofile/kanban', 'WorkProfileController@kanban');
    Route::post('/workprofile/step/delete', 'WorkProfileController@deleteStep')->middleware('history.save');

    //History
    Route::post('/history/list', 'HistoryController@reportList');
    Route::post('/support/list', 'SupportController@renderList');
    Route::post('/support/add',['as'=>'support.add','uses'=>'SupportController@add']);
    Route::post('/support/edit', ['as'=>'support.add','uses'=>'SupportController@edit'])->middleware('history.save');
    Route::post('/support/get', 'SupportController@get');
    Route::post('/support/search',['as'=>'support.customer.search','uses'=>'SupportController@search']);


    // Order
    Route::post('/order/list', 'OrderController@renderList');
    Route::post('/order/kanban', 'OrderController@kanban');
    Route::post('/order/get', 'OrderController@get');
    Route::post('/order/archive', 'OrderController@archive');
    Route::post('/order/state/change', 'OrderController@changeState')->middleware('history.save');
    Route::post('/order/states/update', 'OrderController@changeStates')->middleware('history.save');
    Route::post('/order/paid/update', 'OrderController@updatePaidOrder')->middleware('history.save');
    Route::post('/order/payment/add', 'OrderController@addPayment');
    Route::post('/order/state/delete', 'OrderController@removeState')->middleware('history.save');
    Route::post('/order/state/update', 'OrderController@updateStates')->middleware('history.save');
    Route::post('/order/update', 'OrderController@update')->middleware('history.save');
    Route::post('/order/detail/edit', 'OrderController@editOrder')->middleware('history.save');

    //Report
        
    Route::post('/order/report/list', 'OrderController@OrderReportList');
    Route::post('/order/report/list', 'OrderController@OrderReportList');
    Route::post('/order/report/export', 'OrderController@exportOrderList');
    Route::post('/order/report/weft', 'OrderController@reportWeft');
    //Hair get
    // sale-commission\
    Route::post('/sale-commission/list',['as'=>'sale-commission.list','uses'=>'SaleCommissionController@renderList']);
    Route::post('/sale-commission/get',['as'=>'sale-commission.list','uses'=>'SaleCommissionController@renderDetailList']);

    //dashboard 
    Route::post('/dashboard/get', 'DashBoardController@getData');

    // Edit order
    Route::post('/order/cart/init', 'CartController@init');

});

Route::group(['middleware' => 'jwt.auth'], function () {
    Route::post('/app/init', 'AppController@init');
    // Order
    Route::post('/cart/init', 'CartController@init');
    // Product
    Route::post('/hair/get/{type}/{id}',['as'=>'hair.get','uses'=>'HairController@get']);

    Route::post('/hair/edit/{type}/{id}',['as'=>'hair.edit','uses'=>'HairController@edit']);
    //Hair list
    Route::post('/hair/list/{type}',['as'=>'hair.list','uses'=>'HairController@renderList']);
    //add
    Route::post('/add/hair/{type}',['as'=>'hair.add','uses'=>'HairController@add']);
    Route::post('/cart/product', 'CartController@processProduct');
    Route::post('/customer/search', 'CustomerController@search');
    Route::post('/customer/import', 'CustomerController@importCustomers')->middleware('history.save');
    Route::post('/cart/shipping', 'CartController@processShipping');
    Route::post('/cart/carrier', 'CartController@processCarrier');
    Route::post('/cart/discount', 'CartController@processDiscount');
    Route::post('/cart/payment-fee', 'CartController@processPaymentFee');
    Route::post('/cart/customer', 'CartController@processCustomer');
    Route::post('/cart/saleman', 'CartController@processSaleman');
    Route::post('/cart/address', 'CartController@processAddress');
    Route::post('/address/get', 'CustomerController@getAddress');
    Route::post('/sale/validate', 'CartController@validateOrder');
    Route::post('/hair/delete/{type}/{id}',['as'=>'hair.delete','uses'=>'HairController@delete'])->middleware('history.save');

    // warehouse
    Route::post('/warehouse/list', 'Warehouse\Products\ProductController@getList');
    Route::post('/warehouse/history', 'Warehouse\Products\ProductController@getHistory');
    Route::post('/warehouse/export', 'Warehouse\Products\ProductExportController@export');
    Route::post('/warehouse/import', 'Warehouse\Products\ProductImportController@import');
    Route::post('/warehouse/scanbarcode', 'Warehouse\Products\BarcodeScannerController@scanBarcode');
    Route::post('/warehouse/setting', 'Warehouse\Products\ProductController@setting');
});


//edit

//Route::post('/product/add',['as'=>'product.add','uses'=>'ProductController@add']);
//Route::post('/product/edit',['as'=>'product.add','uses'=>'ProductController@edit']);

Route::post('/work-category/add',['as'=>'work-category.add','uses'=>'WorkProfileController@addCategory']);

Route::post('/work-category/edit',['as'=>'work-category.edit','uses'=>'WorkProfileController@editCategory']);

// cart
//Route::post('/cart/remove',['as'=>'cart.remove','uses'=>'CartController@remove']);
//Route::post('/cart/edit',['as'=>'cart.edit','uses'=>'CartController@edit']);
//Route::post('/cart/get',['as'=>'cart.get','uses'=>'CartController@get']);

Route::delete('/employee/delete/{id}',['as'=>'employee.delete','uses'=>'EmployeeController@delete']);

Route::post('/customer/report/list', 'CustomerController@reportList');
Route::post('/customer/report/export', 'CustomerController@exportList');

//Route::delete('/employee/delete/{id}',['as'=>'employee.delete','uses'=>'EmployeeController@delete']);
//
//Route::post('/customer/report/list', 'CustomerController@reportList');
//Route::post('/customer/report/export', 'CustomerController@exportList');
