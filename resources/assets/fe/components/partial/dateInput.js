import React from 'react';
import PropTypes from 'prop-types';
import 'react-day-picker/lib/style.css';

export default function DateInput({ classNames, selectedDay, children, ...props }) {
    return (
        <div
            className={classNames.overlayWrapper}
            style={{ marginLeft: -100 }}
            {...props}
        >
            <div className={classNames.overlay}>
                <h3>Hello day picker!</h3>
                <p>
                    <input className={'form-control'}/>
                    <button onClick={() => console.log('clicked!')}>button</button>
                </p>
                <p>
                    {selectedDay
                        ? `You picked: ${selectedDay.toLocaleDateString()}`
                        : 'Please pick a day'}
                </p>
                {children}
            </div>
        </div>
    );
}

DateInput.propTypes = {
    classNames: PropTypes.object.isRequired,
    selectedDay: PropTypes.instanceOf(Date),
    children: PropTypes.node.isRequired,
};
