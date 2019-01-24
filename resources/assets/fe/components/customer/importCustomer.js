import React, { Component } from 'react'
import * as XLSX from 'xlsx';
import * as _ from 'lodash'
import { requestImportCustomers, requestGetList } from "../../actions/customer";
import Loading from "../layout/loading";


export default class ImportCustomer extends Component{
    constructor(props){
        super(props);
        this.state = {
            initData: this.props.initData,
            isFetching : false,
        };
        this.onUploadFile = this.onUploadFile.bind(this);
        this.onSuccess = this.onSuccess.bind(this);
        this.onError = this.onError.bind(this);
    }

    onSuccess(){
        this.setState({
            isFetching: false
        });
        this.props.dispatch(requestGetList(this.props.jwt));
    }

    onError(){
        alert('Something went wrong');
        this.setState({
            isFetching: false
        })
    }

    onUploadFile(e){
        const f = e.target.files[0];
        const self = this;

        if (parseFloat(f.name.indexOf(".xls")) > 0 || parseFloat(f.name.indexOf(".xlsx")) > 0) {
            if (f) {
                var r = new FileReader();
                r.onload = function (evt) {
                    const bstr = evt.target.result;
                    const wb = XLSX.read(bstr, {type:'binary'});
                    /* Get first worksheet */
                    const wsname = wb.SheetNames[0];
                    const ws = wb.Sheets[wsname];
                    /* Convert array of arrays */
                    const data = XLSX.utils.sheet_to_json(ws, {header:1});
                    let customers = [];
                    try{
                        data.forEach((row, i) => {
                            customers.push(row);
                        });

                        if(!_.isEmpty(customers)){
                            self.setState({
                                isFetching: true
                            });
                            self.props.dispatch(requestImportCustomers(self.props.jwt, customers, self.props.idCart, self.onSuccess, self.onError))
                        }else{
                            alert('Invalid value');
                        }

                    }catch(err){
                        alert('Something went wrong');
                    }

                    /* Update state */
                }
                r.readAsBinaryString(f)
            }
        }else{
            alert('Invalid Format');
        }
    }

    render(){
        const {isFetching} = this.state;
        if(isFetching) return <Loading/>;
        return(
            <div className={"btn-upload"}>
                <button  onClick={(e) => {
                    this.refs.fileUploader.click();
                }} > Import Customers</button>
                <input type="file" onChange={(event) => this.onUploadFile(event)} id="file" ref="fileUploader"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style={{display: "none"}}/>
            </div>
        )
    }
}
