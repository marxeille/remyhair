import React, { Component } from 'react'
import * as XLSX from 'xlsx';
import * as _ from 'lodash'
import {requestImportProducts} from "../../../actions/order/product";

export default class ImportProduct extends Component{
    constructor(props){
        super(props);
        this.state = {
            initData: this.props.initData,
        };
        this.onUploadFile = this.onUploadFile.bind(this);
        this.getIdHairData = this.getIdHairData.bind(this);
        this.onSuccess = this.onSuccess.bind(this);
        this.onError = this.onError.bind(this);
    }

    getIdHairData(key, data){
        const result =  _.first(_.filter(data, (d) => d.name.toLowerCase() == key.toLowerCase()));
        return result ? result.id : null;
    }

    onSuccess(){
        this.setState({
           isFetching: false
        });
    }

    onError(){
        alert('Something went wrong');
        this.setState({
            isFetching: false
        })
    }

    onUploadFile(e){
        const { initData } = this.state;
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
                    let products = [];
                    try{
                        data.forEach((row, i) => {
                            if(i){
                                let id_hair_size = self.getIdHairData(row[0], initData.hair_sizes);
                                let id_hair_type = self.getIdHairData(row[1], initData.hair_types);
                                let id_hair_style = self.getIdHairData(row[2], initData.hair_styles);
                                let id_hair_color = self.getIdHairData(row[3], initData.hair_colors);
                                let id_hair_draw = self.getIdHairData(row[4], initData.hair_draws);
                                let kg = parseFloat(row[5]);
                                let price = parseFloat(row[6]);

                                if(id_hair_size && id_hair_type && id_hair_style && id_hair_color && id_hair_draw && kg && price >=0){
                                    products.push({
                                        id_hair_size:  id_hair_size,
                                        id_hair_type:  id_hair_type,
                                        id_hair_style:  id_hair_style,
                                        id_hair_color:  id_hair_color,
                                        id_hair_draw:  id_hair_draw,
                                        kg:  kg,
                                        price:  price,
                                    });
                                }

                            }
                        });
                        if(!_.isEmpty(products)){
                            self.setState({
                                isFetching: true
                            });
                            self.props.dispatch(requestImportProducts(self.props.jwt, products, self.props.idCart, self.props.isEditing, self.props.onSuccess.bind(this), self.onError))
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
        return(
            <div className={"btn-upload"}>
                <button  onClick={(e) => {
                    this.refs.fileUploader.click();
                }} > Upload file </button>
                <input type="file" onChange={(event) => this.onUploadFile(event)} id="file" ref="fileUploader"  accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style={{display: "none"}}/>
            </div>
        )
    }
}
