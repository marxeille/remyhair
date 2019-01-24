import React, { Component } from 'react'
import { resize, imgCheck} from "../../utility";

const defaultImage = 'http://hair68.com/img/logo.jpg?1528476710';
export default class OrderNote extends Component{
    constructor(props){
        super(props);
        if(this.props.isEditing) {
            localStorage.setItem('note', this.props.order.note != null ? this.props.order.note : '');
            localStorage.setItem('reason', this.props.order.reason != null ? this.props.order.reason : '');
        }
        this.state = {
            cart: this.props.cart,
            note: (this.props.isEditing) ? this.props.order.note :  localStorage.getItem('note') == null ? localStorage.getItem('note') : '',
            reason: (this.props.isEditing) ? this.props.order.reason : localStorage.getItem('reason') == null ? localStorage.getItem('reason') : '',
            loading: false,
            img: (this.props.isEditing) ? this.props.order.img ? this.props.order.img : defaultImage : defaultImage
        };
        this.saveNote = this.saveLocalStorage.bind(this);
        this.uploadImage = this.uploadImage.bind(this);
        this.deleteImage = this.deleteImage.bind(this);
    }
    uploadImage(event){
        if(imgCheck(event.target.files[0])){
            resize(event.target.files[0], 1024, 720, base64 => {
                localStorage.setItem('image', base64);
                this.setState({
                    img: base64
                })
            });
        }
    }
    deleteImage() {
        localStorage.removeItem('image');
        this.setState({
            img: defaultImage
        })
    }
    saveLocalStorage(name){
        localStorage.setItem(name, this.state[name]);       
    }

    render(){
        return(
            <div className="note-and-image">
                <div className="note-reason clearfix">
                    <div className="note">
                        <img className={"image-uploaded"} src={ this.state.img} />
                        {
                            this.state.img != defaultImage ? 
                                <a href="javascrip::void(0)" className="btn btn-block btn-sm" onClick={(e) => this.deleteImage()}><i className="fa fa-remove"></i></a> 
                            : 
                                null
                        }
                        {
                            this.state.img == defaultImage ? 
                                <button className="upload-img" onClick={(e) => {this.refs.fileUploader.click();}} title="upload image">Upload Image</button>
                            : 
                                null  
                        }
                        <input type="file" id="file" ref="fileUploader" onChange={this.uploadImage.bind(this)} style={{display: "none"}}/>  
                    </div>
                    <div className="reason">
                        <textarea placeholder="Note" name="note" defaultValue={this.state.note} onChange={(e) => this.setState({ note: e.target.value })} onBlur={(e) => this.saveLocalStorage(e.target.name)} ></textarea>
                        <textarea placeholder="Reason" name="reason" defaultValue={this.state.reason} onChange={(e) => this.setState({ reason: e.target.value })} onBlur={(e) => this.saveLocalStorage(e.target.name)} ></textarea>
                    </div>
                </div>
            </div>

        )
    }

}
