import React, { Component} from 'react';
import Input from "../../components/partial/input";
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import ClassNames from "classnames";
import * as _ from 'lodash'

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
export default class AddProcedureStep extends Component{
    constructor(props){
        super(props);
        this.state = {
            steps: this.props.steps,
            errors:{}
        };
        this.onDragEnd = this.onDragEnd.bind(this);
        this.addStep = this.addStep.bind(this);
        this.updateSteps = this.updateSteps.bind(this);
    }

    onDragEnd(result) {
        // dropped outside the list
        if (!result.destination) {
            return;
        }

        const steps = this.reorder(
            this.state.steps,
            result.source.index,
            result.destination.index
        );

        this.setState({
            steps,
        });
        this.updateSteps()
    }

    reorder(list, startIndex, endIndex){
        const result = Array.from(list);
        const [removed] = result.splice(startIndex, 1);
        result.splice(endIndex, 0, removed);

        return result;
    };

    removeStep(id){
        const steps = _.filter(this.state.steps, (step) => {
            if(step.id != id) return step;
        });
        this.setState({
            steps: steps
        })
    };

    updateSteps(){
        this.props.updateSteps(this.state.steps);
    }

    componentWillReceiveProps(props){
        if(!_.isEqual(props.steps, this.props.steps)) this.setState({
            steps: props.steps
        })
    }

    onChangeValue(id, event) {
        const steps = this.state.steps.map((step) => {
           if(step.id == id) {
               return Object.assign(step, {
                   name: event.target.value,
                   error: !event.target.value
               })
           }
           return step;
        });
        this.setState({
              steps
          });
        }

        addStep(){
            const maxId = _.maxBy(this.state.steps, (step) =>  step.id);
            this.state.steps.push({
                id: parseInt(maxId.id) + 1,
                name: '',
                value: '',
            });
            this.setState({
                steps: this.state.steps
            })
        }

    render(){
        const { steps } = this.state;
        return(
            <div className="addProcedureStepView">
                <h1>Steps</h1>
                <DragDropContext onDragEnd={this.onDragEnd} >
                    <Droppable droppableId="droppable" direction="horizontal">
                        {(provided, snapshot) => (
                            <div
                                ref={provided.innerRef}
                                style={getListStyle(snapshot.isDraggingOver)}
                                {...provided.droppableProps}
                            >
                                {this.state.steps.map((step, index) => (
                                    <Draggable key={step.id} draggableId={step.id} index={index}>
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
                                                <div className={ClassNames({'form-group input-step-proce': true}, {'has-error input-step-proce': step.error})}>
                                                    <input type={'text'} className="form-control"  value={step.name} name={'name'} placeholder={'Enter step name'} onBlur={this.updateSteps} onChange={this.onChangeValue.bind(this, step.id)} />
                                                </div>
                                                {_.size(steps) >1 && <button onClick={this.removeStep.bind(this, step.id)} className="btn-delete-step"><i className="fa fa-trash"></i></button>}
                                            </div>
                                        )}
                                    </Draggable>
                                ))}
                                 <button className ="btn-add-step"  onClick={this.addStep}>+ Create a new step</button>
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

class ProcedureStep extends Component{
    constructor(props){
        super(props);
        this.state = {
            name: this.props.step.name,
            number: this.props.step.number,
            erros: {
                name: '',
                number: ''
            }
        }
    }

    render(){
        return(
            <form>

            </form>
        )
    }
}
