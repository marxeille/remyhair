import React, {PureComponent} from 'react';
import _ from 'lodash';
import Api from '../../../api';
import WorkProfileDescription from "./workProfileDescription";
import WorkProfileActivity from "./workProfileActivity";

export default class DetailKanban extends PureComponent{
    constructor(props) {
        super(props);
        this.archive = this.archive.bind(this);
    }

    archive(){
        if(confirm('Archive?')){
            this.props.archive();
        }
    }

    render(){
        const {employee, detail} = this.props;
        return (
            <div className="kanban-popup">
                <button className="btn-close-popup" onClick={() => this.props.close()}></button>
                {employee.id == detail.id_leader || employee.id_group == 1 ||  employee.id == detail.id_employee ?
                    <div>
                        <div className="title-popup"><h3 className="title-form">Detail</h3></div>
                        <label htmlFor="desc">Employee:</label>
                        <p>{detail.employee.name}</p>
                        <WorkProfileDescription workProfile={detail} jwt={this.props.jwt}/>
                        <WorkProfileActivity
                            idWorkProfile={detail.id}
                            jwt={this.props.jwt}
                            employee={employee}
                            activity={!_.isEmpty(detail.comment) ? detail.comment : []}
                        />
                        <div className="btn-view-popup">
                            <button className="save-button" onClick={this.archive}>Archive</button>
                        </div>
                    </div>
                    :
                     null
                }
            </div>
        )
    }
}
