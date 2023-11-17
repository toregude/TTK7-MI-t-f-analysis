
bigData = createParticipantData(13);
save('allParticipantsEEGData13.mat', 'bigData');

function participants = createParticipantData(numParticipants)
    participants = struct();
    dataStruct = struct();
    % Loop through participants and add data.
    for i = 1:numParticipants
        participantNum = sprintf('P%03d', i); % e.g., 'P001', 'P002', etc.
        dataNameValidation = sprintf("data/S%02dE.mat",i);
        dataNameTrain = sprintf("data/S%02dT.mat",i);
        dataStruct.train = load(dataNameTrain);
        dataStruct.validation = load(dataNameValidation);
        for j = 1:5
            runNum = sprintf('R%03d', j);
            val = dataStruct.train.data(j);
            dataStruct.train.(runNum) = val{1,1};
        end
        for j = 1:3
            runNum = sprintf('R%03d', j);
            val = dataStruct.validation.data(j);
            dataStruct.validation.(runNum) = val{1,1};
        end
        dataStruct.train = rmfield(dataStruct.train, 'data');
        dataStruct.validation = rmfield(dataStruct.validation, 'data');

   
        % Add the participant data to the structured array.
        participants.(participantNum) = dataStruct;
    end
end
