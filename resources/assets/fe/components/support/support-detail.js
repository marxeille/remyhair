<div className="box box-primary">
    <div className="box-header with-border text-center">
        <h1 className="box-title">Support</h1>
    </div>
    <form className="form-horizontal">
        <div className="box-body">
            <div className="row">
                <div className="col-xs-7 col-md-10">
                    <div id="custom-search-input">
                        <div className="input-group col-md-12">
                            <input type="text" className="form-control" placeholder="search here..." />
                            <span className="input-group-btn">
                                    <button className="btn btn-info" type="button">
                                        <i className="glyphicon glyphicon-search"></i>
                                    </button>
                                    </span>
                        </div>
                    </div>
                </div>
                <div className="col-xs-5 col-md-2">
                    <button className="btn pull-right">Create Custom</button>
                </div>
            </div>
        </div>
        <div className="box-body">
            <div className="row">
                <div className="col-xs-6">
                    <label>Invoice status</label>
                    <select className="form-control">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                    </select>
                </div>
                <div className="col-xs-6">
                    <label>Invoice Number</label>
                    <input className="form-control" type="text" placeholder="Default input" />
                </div>
            </div>
        </div>
        <div className="box-body">
            <label>Complain</label>
            <textarea className="form-control" rows="5"></textarea>
        </div>
        <div className="box-body">
            <label>Payment</label>
            <select className="form-control">
                <option>Payment 1</option>
                <option>Payment 2</option>
                <option>Payment 3</option>
            </select>
        </div>
        <div className="box-body row">
            <div className="col-xs-6">
                <label>Total Kg</label>
                <input type="email" className="form-control" placeholder="Enter Kg" />
            </div>
            <div className=" col-xs-6">
                <label>Source</label>
                <input type="text" className="form-control" />
            </div>
        </div>
        <div className="box-body">
            <label>Note</label>
            <textarea className="form-control" rows="3" placeholder="note"></textarea>
        </div>
        <div className="box-body input-group input-group-sm">
            <textarea type="text" className="form-control"></textarea>
            <span className="input-group-btn">
                      <button type="button" className="btn btn-info btn-flat" onClick={this.onAdd.bind(this)}>ADD</button>
                    </span>
        </div>
        {/*{indents}*/}
        <div className="box-footer">
            <button type="submit" className="btn btn-default">Cancel</button>
            <button type="submit" className="btn btn-info pull-right">Save</button>
        </div>
    </form>
</div>


// class AddNote extends Component{
//     render(){
//         return(
//             <div className="box-body input-group input-group-sm">
//                 <textarea type="text" className="form-control"></textarea>
//                 <span className="input-group-btn">
//                     <button type="button" className="btn btn-info btn-flat" onClick={() => this.onAdd()}>ADD</button>
//                 </span>
//             </div>
//         )
//     }
// }
