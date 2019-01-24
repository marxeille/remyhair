import React, { Component} from 'react';
import Input from "../partial/input";
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import ClassNames from "classnames";
import * as _ from 'lodash'
import Api from "../../api";

const grid = 8;
const getItemStyle = (isDragging, draggableStyle) => ({
    // some basic styles to make the items look a bit nicer
    userSelect: 'none',
    margin:`0px 15px 0px 0px`,
    // change background colour if dragging
    background: isDragging ? 'lightgreen' : 'bisque',

    // styles we need to apply on draggables
    ...draggableStyle,
});
export default class EditState extends Component{
    constructor(props){
        super(props);
        const states = _.sortBy(this.props.states, "number");
        this.state = {
            states: states,
            errors:{}
        };
        this.onDragEnd = this.onDragEnd.bind(this);
        this.addState = this.addState.bind(this);
        this.updateStates = this.updateStates.bind(this);
    }

    onDragEnd(result) {
        // dropped outside the list
        if (!result.destination) {
            return;
        }
        const states = this.reorder(
            this.state.states,
            result.source.index,
            result.destination.index
        );

        this.setState({
            states,
        });
        this.updateStates()
    }

    reorder(list, startIndex, endIndex){
        const result = Array.from(list);
        const [removed] = result.splice(startIndex, 1);
        result.splice(endIndex, 0, removed);

        return result;
    };

    async removeState(id){
        const states = _.filter(this.state.states, (state) => {
            if(state.id != id) return state;
        });
        const state = _.first(_.filter(this.state.states, (state) => {
            if(state.id == id) return state;
        }));
        if(!state.add){
            try {
                const response = await Api.removeOrderStates(this.props.jwt, id);
                const result = JSON.parse(response.text);
                if(result.status){
                    this.setState({
                        states: states
                    });
                }else{
                    alert('Something went wrong');
                }
            }catch(err){
                alert(err.message)
            }
        }else{
            this.setState({
                states: states
            });
        }

    };

    updateStates(){
        this.props.updateStates(this.state.states);
    }

    componentWillReceiveProps(props){
        if(!_.isEqual(props.steps, this.props.states)) this.setState({
            states: props.states
        })
    }

    onChangeValue(id, event) {
        const states = this.state.states.map((state) => {
           if(state.id == id) {
               return Object.assign(state, {
                   name: event.target.value,
                   error: !event.target.value
               })
           }
           return state;
        });
        this.setState({
            states: states
          });
        }

     addState(){
            const maxId = _.maxBy(this.state.states, (state) =>  state.id);
            this.state.states.push({
                id: (maxId) ? parseInt(maxId.id) + 1 : 1,
                name: '',
                value: '',
                add: true
            });
            this.setState({
                states: this.state.states
            })
        }

    render(){
        const { states } = this.state;
        return(
            <div className="addProcedureStepView">
                <DragDropContext onDragEnd={this.onDragEnd}>
                    <Droppable droppableId="droppable" direction="horizontal">
                        {(provided, snapshot) => (
                            <div
                                ref={provided.innerRef}
                                style={getListStyle(snapshot.isDraggingOver)}
                                {...provided.droppableProps}
                            >
                                <button onClick={this.addState} className ="btn-add-step" >+ Create a new state</button>
                                {states.map((state, index) => (
                                    <Draggable key={state.id} draggableId={state.id} index={index}>
                                        {(provided, snapshot) => (
                                            <div
                                                ref={provided.innerRef}
                                                {...provided.draggableProps}
                                                {...provided.dragHandleProps}
                                                style={getItemStyle(
                                                    snapshot.isDragging,
                                                    provided.draggableProps.style
                                                )}
                                            >
                                                <div className={ClassNames({'form-group input-step-proce': true}, {'has-error input-step-proce': state.error})}>
                                                    <input type={'text'} className="form-control"  value={state.name} name={'name'} placeholder={'Enter state name'} onBlur={this.updateStates} onChange={this.onChangeValue.bind(this, state.id)} />
                                                </div>
                                                {_.size(state) >1 && 
                                                    <button 
                                                        onClick={() => {
                                                            if(confirm('Are you sure?')){
                                                                this.removeState.bind(this, state.id)
                                                            }
                                                        }}
                                                        className="btn-delete-step"
                                                    >
                                                        <i className="fa fa-trash"></i>
                                                    </button>
                                                }
                                            </div>
                                        )}
                                    </Draggable>
                                ))}
                                {provided.placeholder}
                            </div>
                        )}
                    </Droppable>
                </DragDropContext>
            </div>

        )
    }
}

const getListStyle = isDraggingOver => ({
    background: isDraggingOver ? '#eeeeee' : 'white',
    display: 'flex',
    padding: `10px 10px 10px 10px `,
    overflow: 'auto',
    position: 'relative'
});
