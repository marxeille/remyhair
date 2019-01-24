import React, { Component } from 'react';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import * as _ from 'lodash';
import {requestUpdateState, requestUpdateOrder, requestArchiveOrder, requestGetListForKanban} from "../../actions/order";
import Loading from "../layout/loading";
import {showPrice} from "../../utility";
import Popup from "reactjs-popup";
import moment from "frozen-moment";
import "react-datepicker/dist/react-datepicker.css";
import Api from "../../api";
import OrderKanbanPopup from "./kanbanPopUp";
import ClassNames from "classnames";
import DatePicker from "react-datepicker/es";

const grid = 5;

const getItemStyle = (isDragging, draggableStyle) => ({
    // some basic styles to make the items look a bit nicer
    userSelect: 'none',
    padding: grid * 2,
    margin: `0 0 ${grid}px 0`,

    // change background colour if dragging
    background: isDragging ? 'lightgray' : 'white',

    // styles we need to apply on draggables
    ...draggableStyle
});
const getListStyle = isDraggingOver => ({
    background: isDraggingOver ? '#eeeeee' : '#e6e6e6',
    padding: grid,
    width: '250px'
});

export default class KanbanTable extends Component {
    constructor(props){
        super(props);
        this.states = _.sortBy(this.props.kanbanData, "number");
        this.state = {
            states: this.states,
            items: props.items,
            filters: props.filters
        };
        this.onDragEnd = this.onDragEnd.bind(this);
        this.saveNoteReason = this.saveNoteReason.bind(this);
        this.archive = this.archive.bind(this);
    }

    onDragEnd (result) {
        const { draggableId, source, destination } = result;
        // dropped outside the list
        if (!destination) {
            return;
        }

        const sourceDroppableId = parseInt(source.droppableId.replace("orderStatus_", ""));
        const destinationDroppableId = parseInt(destination.droppableId.replace("orderStatus_", ""));
        
        const {items} = this.state;
        let itemByDestination = _.orderBy(_.filter(items, (item) => {return item.current_status == destinationDroppableId}), ['position'], ['asc']);
        const cloneItemByDestination = _.clone(itemByDestination);
        const itemSelected = _.find(items, (item) => {return item.id == draggableId});
        
        if(sourceDroppableId == destinationDroppableId) {
            const [itemDrag] = cloneItemByDestination.splice(source.index, 1);
            cloneItemByDestination.splice(destination.index, 0, itemDrag);
            itemByDestination = cloneItemByDestination;
        } else {
            itemSelected.current_status = destinationDroppableId;
            cloneItemByDestination.splice(destination.index, 0, itemSelected);
        }
        
        // sort lại position
        cloneItemByDestination.map( (item, index) => { 
            return item.position = index;
        });

        const sortItem = items.map((item) => {
            const itemDestination = _.find(cloneItemByDestination, (itemBy) => {return itemBy.id == item.id});
            if (typeof itemDestination !== 'undefined') {
                item.position = itemDestination.position;
                item.current_status = itemDestination.current_status;
            }
            return item;
        });

        this.setState({
            items: sortItem,
        });
        this.props.dispatch(requestUpdateState({jwt: this.props.jwt, orders: cloneItemByDestination}));
        
    };
    async showDetail(id){
        try{
            this.setState({
                loading: true
            });
            const response = await Api.requestOrder(this.props.jwt, id);
            const result = JSON.parse(response.text);
            this.setState({
                showDetailPopup: true,
                isGettingDetail: true,
                detail: result.data,
                loading: false
            });
        }catch(e){
            alert('some thing went wrong');
        }

    }

    async saveNoteReason(){
        const {detail} = this.state;
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestUpdateOrder({
            jwt: this.props.jwt,
            update:{
                id: detail.id,
                note: this.note.value,
                reason: this.reason.value,
                date_ship: new moment(detail.date_ship).format('YYYY-MM-DD'),
            }
        }));
    }

    onChangeDate(field, date) {
        this.setState({
            detail: Object.assign({}, this.state.detail, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    componentWillReceiveProps(props){
        this.setState({
            isFetching: false,
            showDetailPopup: false,
            isGettingDetail: false,
            detail: {},
            filters: props.filters,
            items: props.items
        });
    }

    onChangeDateFilter(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date
            })
        });
    }

    async archive(){
        if(!_.isEmpty(this.state.detail)){
            await Api.archiveOrder(this.props.jwt, this.state.detail.id);
            this.props.dispatch(requestArchiveOrder((this.state.detail.id)));
        }
    }

    onRequestFilter(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestGetListForKanban({jwt: this.props.jwt, filter: this.state.filters}));
    }

    render() {
        const { states, items, isFetching, showDetailPopup, isGettingDetail, detail, filters } = this.state;
        const now = new moment();
        if(isFetching) return <Loading/>;
        return (
            <div>
                <div className="filter-report">
                    <div className="filter-from">
                        <span>From:</span>
                        <div className="datePicker">
                            <DatePicker
                                showYearDropdown
                                selected={!_.isEmpty(filters.from) ? moment(filters.from) : null}
                                onChange={this.onChangeDateFilter.bind(this, 'from')}
                                className="form-control"
                                dateFormat="DD/MM/YYYY"
                            />
                        </div>
                    </div>
                    <div className="filter-to">
                        <span>To:</span>
                        <div className="datePicker">
                            <DatePicker
                                showYearDropdown
                                selected={!_.isEmpty(filters.to) ? moment(filters.to) : null}
                                onChange={this.onChangeDateFilter.bind(this, 'to')}
                                className="form-control"
                                dateFormat="DD/MM/YYYY"
                            />
                        </div>
                    </div>
                    <button className="btn-filter" onClick={this.onRequestFilter.bind(this)}> <i className={'fa fa-filter'}></i></button>
                </div>
                <div className="kanbanWProduce">
                    <DragDropContext onDragEnd={this.onDragEnd}>
                        {states.map((state) => (
                            <Droppable droppableId={`orderStatus_${state.id}`} key={state.id}>
                                {(provided, snapshot) => (
                                    <div className={"table-cell"}>
                                        <div
                                            className={"table-cell-content"}
                                            key={`${state.id}`}
                                            ref={provided.innerRef}
                                            style={getListStyle(snapshot.isDraggingOver)}>
                                            <h4>{state.name}</h4>
                                            <div className="kanban-content">
                                                {_.orderBy(_.filter(items, (item) => item.current_status === state.id), ['position'], ['asc']).map((item, index) => (
                                                    <Draggable
                                                        key={item.id}
                                                        draggableId={item.id}
                                                        index={index}>
                                                        {(provided, snapshot) => (
                                                            <div
                                                                key={item.id}
                                                                ref={provided.innerRef}
                                                                {...provided.draggableProps}
                                                                {...provided.dragHandleProps}
                                                                onClick={() => this.showDetail(item.id)}
                                                                style={getItemStyle(
                                                                    snapshot.isDragging,
                                                                    provided.draggableProps.style
                                                                )}
                                                                className={ClassNames(
                                                                    {
                                                                        "item-task": true,
                                                                        'low-piority':  parseInt(moment(item.date_ship).diff(now, 'days')) > 3,
                                                                        'medium-piority':  parseInt(moment(item.date_ship).diff(now, 'days')) >=  2 &&  parseInt(moment(item.date_ship).diff(now, 'days')) < 3,
                                                                        'hight-piority':  parseInt(moment(item.date_ship).diff(now, 'days')) <= 1,
                                                                    })}
                                                            >
                                                                <p>{`# ${item.id}`}</p>
                                                                <p>{`date ship: ${item.date_ship}`}</p>
                                                                <p>{`Customer: ${item.customer}`}</p>
                                                                <p>{`Supporter: ${item.saleman}`}</p>
                                                                <p>{`KG: ${item.kg}`}</p>
                                                                <p>{`Total: ${showPrice(item.total_paid)}`}</p>
                                                                <p>{item.total_unpaid ? `Unpaid: ${item.total_unpaid}` : 'Fully paid' }</p>
                                                            </div>
                                                        )}
                                                    </Draggable>
                                                ))}
                                            </div>
                                        </div>
                                    </div>
                                )}
                            </Droppable>
                        ))}
                    </DragDropContext>
                    <Popup overlayStyle={{position:'absolute'}} contentStyle={{width: '70%'}} open={showDetailPopup} onClose={() => this.setState({showDetailPopup: false})} modal>
                        {isGettingDetail &&
                        <OrderKanbanPopup
                            detail={detail}
                            env={this.props.env}
                            employee={this.props.employee}
                            archive={this.archive}
                            jwt={this.props.jwt} />
                        }
                    </Popup>
                </div>
            </div>
        );
    }
}

// Put the things into the DOM!
