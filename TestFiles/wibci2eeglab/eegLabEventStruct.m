function [ eventStruct ] = eegLabEventStruct(softEventAVector, softEventBVector, hardEventAVector, hardEventBVector)
%eegLabEventStruct Takes an event times vector and returns a eeglab
%   compatible event structure.

eventStruct = struct([]);
eventStruct = insertEvents(softEventAVector, 'ST A', eventStruct, 0);
eventStruct = insertEvents(softEventBVector, 'ST B', eventStruct, length(softEventAVector));
eventStruct = insertEvents(hardEventAVector, 'HT A', eventStruct, length(softEventAVector)+length(softEventBVector));
eventStruct = insertEvents(hardEventBVector, 'HT B', eventStruct, length(softEventAVector)+length(softEventBVector)+length(hardEventAVector));

    function eventStruct = insertEvents(eventVector, eventType, eventStruct, numEventsOffset)
        numEvents = length(eventVector);
        for eventNum = 1:numEvents
            eventStruct(eventNum+numEventsOffset).('type') = eventType;
            eventStruct(eventNum+numEventsOffset).('latency') = eventVector(eventNum);
            eventStruct(eventNum+numEventsOffset).('duration') = 1; % Number of samples
            eventStruct(eventNum+numEventsOffset).('urevent') = eventNum+numEventsOffset;
        end
    end

end