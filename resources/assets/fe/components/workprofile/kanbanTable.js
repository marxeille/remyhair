import React, { Component } from 'react';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import * as _ from 'lodash';
import {
    requestUpdateState,
    addLeaderSuggesstion,
    requestArchiveWorkProfile,
    requestGetListForKanban
} from "../../actions/workprofile";
import Loading from "../layout/loading";
import Popup from "reactjs-popup";
import Api from '../../api';
import DetailKanban from "./kanbanDetail/detailKanban";
import moment from 'moment';
import ClassNames from "classnames";
import DatePicker from "react-datepicker/es";
import FilterFromTo from "../helper/filterFromTo";
const grid = 8;

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
    width: `250px`
});

export default class KanbanTable extends Component {
    constructor(props){
        super(props);
        this.procedure = _.first(props.data);
        this.procedure.procedure_steps = _.sortBy(this.procedure.procedure_steps, "number");
        this.state = {
            procedure: this.procedure,
            items: props.items,
            filters: props.filters
        };
        this.onDragEnd = this.onDragEnd.bind(this);
        this.getList = this.getList.bind(this);
        this.move = this.move.bind(this);
        this.onChangeProcedure = this.onChangeProcedure.bind(this);
        this.archive = this.archive.bind(this);
        this.onChangeDate = this.onChangeDate.bind(this);
    }

    move(source, destination, droppableSource, droppableDestination){
       const item = _.first(_.filter(source, (item, index) => index == droppableSource.index));
        item.id_status = droppableDestination.droppableId;

        return this.state.items.map((i) => {
           if(i.id == item.id)  return item;
           return i;
        });
    };

    /**
     * A semi-generic way to handle multiple lists. Matches
     * the IDs of the droppable container to the names of the
     * source arrays stored in the state.
     */


    getList (id) {
      return  _.filterthis.state.items[[id]]
    };

    componentWillReceiveProps(props){
        if(!_.isEmpty(props.items)){
            this.procedure = _.first(_.filter(props.data, (item) =>{
                return item.title === _.first(props.items).id_procedure
            }));
        }
        this.procedure.procedure_steps = _.sortBy(this.procedure.procedure_steps, "number");
           this.setState({
           isFetching: false,
           showDetailPopup: false,
           isGettingDetail: false,
           procedure: this.procedure,
           detail: {},
           filters: props.filters,
           items: props.items
       });
    }

    onChangeDate(field, date) {
        this.setState({
            filters: Object.assign({}, this.state.filters, {
                [field]: date.format('YYYY-MM-DD 23:59:59')
            })
        });
    }

    onDragEnd (result) {
        const { draggableId, source, destination } = result;
        // dropped outside the list
        if (!destination) {
            return;
        }

        const sourceDroppableId = parseInt(source.droppableId.replace("drag_", ""));
        const destinationDroppableId = parseInt(destination.droppableId.replace("drag_", ""));

        const {items} = this.state;
        let itemByDestination = _.orderBy(_.filter(items, (item) => {return item.id_status == destinationDroppableId}), ['position'], ['asc']);
        const cloneItemByDestination = _.clone(itemByDestination);
        const itemSelected = _.find(items, (item) => {return item.id == draggableId});

        if(sourceDroppableId == destinationDroppableId) {
            const [itemDrag] = cloneItemByDestination.splice(source.index, 1);
            cloneItemByDestination.splice(destination.index, 0, itemDrag);
        } else {
            itemSelected.id_status = destinationDroppableId;
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
        this.props.dispatch(requestUpdateState({jwt: this.props.jwt, workProfiles: cloneItemByDestination}));
    };

    async showDetail(id){
        try{
            this.setState({
                loading: true
            });
            const response = await Api.getWorkProfileDetail(this.props.jwt, id);
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

    async saveSuggesstion(){
        const {detail} = this.state;
        this.setState({
            isFetching: true
        });
        this.props.dispatch(addLeaderSuggesstion({jwt: this.props.jwt, id: detail.id, suggesstion: this.suggesstion.value}));
    }

    async archive(){
        if(!_.isEmpty(this.state.detail)){
            await Api.archiveWorkProfile(this.props.jwt, this.state.detail.id);
            this.props.dispatch(requestArchiveWorkProfile((this.state.detail.id)));
        }
    }

    onRequestFilter(){
        this.setState({
            isFetching: true
        });
        this.props.dispatch(requestGetListForKanban({jwt: this.props.jwt, filter: this.state.filters}));
    }

    onChangeProcedure(event){
          this.setState({
              filters: {
                  ...this.state.filters,
                  id_procedure: Object.assign({}, this.state.filters.id_procedure, {
                      value: event.target.value
                  })
              }
          });
          this.procedure = _.first(_.filter(this.props.data, (item) =>{
              return item.title === event.target.value
          }));
    }

    render() {
        const { procedure, items, isFetching, showDetailPopup, isGettingDetail, detail, filters } = this.state;
        const {employee} = this.props;
        if(isFetching) return <Loading/>;
        const now = new moment();
        return (
            <div>
                <div className="filter-report">
                    <FilterFromTo filter={filters} onChangeDate={this.onChangeDate} />
                    <div className="filter-to">
                        <select className="form-control" defaultValue={procedure.title} onChange={this.onChangeProcedure}>
                            {this.props.data.map(item => (
                                <option value={item.title} key={item.id}>{item.title}</option>
                            ))}
                        </select>
                    </div>
                    <button className="btn-filter" onClick={this.onRequestFilter.bind(this)}> <i className={'fa fa-filter'}></i></button>
                </div>
                <div className="kanbanWProduce">
                    <DragDropContext onDragEnd={this.onDragEnd}>
                        {procedure.procedure_steps.map((step) => (
                            <Droppable droppableId={`drag_${step.id}`} key={step.id}>
                                {(provided, snapshot) => (
                                    <div className={"table-cell"}>
                                        <div
                                            className={"table-cell-content"}
                                            key={`a${step.id}`}
                                            ref={provided.innerRef}
                                            style={getListStyle(snapshot.isDraggingOver)}>
                                            <h4>{step.name}</h4>
                                            { _.orderBy(_.filter(items, (item) => item.id_status === step.id), ['position'], ['asc']).map((item, index) => (
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
                                                            style={getItemStyle(
                                                                snapshot.isDragging,
                                                                provided.draggableProps.style
                                                            )}
                                                            className={ClassNames(
                                                                {
                                                                    "item-task": true,
                                                                    'low-piority': parseInt(now.diff(moment(item.created_at), 'days')) >=  1 && parseInt(now.diff(moment(item.created_at), 'days')) < 2,
                                                                    'medium-piority': parseInt(now.diff(moment(item.created_at), 'days')) >=  2 && parseInt(now.diff(moment(item.created_at), 'days')) < 3,
                                                                    'hight-piority': parseInt(now.diff(moment(item.created_at), 'days')) >=  3,
                                                                })}
                                                            onClick={() => this.showDetail(item.id)}
                                                        >
                                                            <p>Title: {item.title}</p>
                                                            <p>Employee: {item.employee_name}</p>
                                                            <p>Work category: -{item.work_category_name}-</p>
                                                        </div>
                                                    )}
                                                </Draggable>
                                            ))}
                                        </div>
                                    </div>
                                )}
                            </Droppable>
                        ))}
                    </DragDropContext>
                    <Popup open={showDetailPopup} onClose={() => this.setState({showDetailPopup: false})} modal>
                        {isGettingDetail &&
                        <DetailKanban
                            detail={detail}
                            jwt={this.props.jwt}
                            archive={this.archive}
                            close={() => this.setState({showDetailPopup: false})} employee={employee}/>
                        }
                    </Popup>
                </div>
            </div>

        );
    }
}

// Put the things into the DOM!
