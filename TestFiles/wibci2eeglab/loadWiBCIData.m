function WiBCIData = loadWiBCIData(filePath, fillMissingPackets)

KOTLIN_ULONG_MAX_VAL = 2^64 -1;

fileAsTable = readtable(filePath);

fileAsArray = table2array(fileAsTable);
fileAsArray(isnan(fileAsArray)) = 0.0;

fileAsArray(2:end, 1) = fileAsArray(2:end, 1) + 1;
fileAsArray(2:end, 2:3) = fileAsArray(2:end, 2:3) + 4000;

fileAsArray(2:end, 4:19) = fileAsArray(2:end, 4:19) .* 0.02235;

fileAsArray(fileAsArray(:, 1) >= KOTLIN_ULONG_MAX_VAL, 1) = 1;

dataMatrix = cumsum(fileAsArray);

[dataMatrix, numMissing] = appendNans(dataMatrix);

if ~isempty(find(diff(dataMatrix(:, 1)) > 1, 1))
    error('Missing packet identification failed. Kindly send the data file to WiBCI developers for debugging.');
end

warning('%.1f percent of data is missing', numMissing/size(dataMatrix, 1)*100);

if(fillMissingPackets)
    dataMatrix = fillmissing(dataMatrix, "pchip");
    warning('Missing data is filled using pchip method. For more details, see "help fillmissing" in MATLAB.');
end

WiBCIData.channelData = dataMatrix;

dataChannelNames = getChannelNames(fileAsTable, 4:19);

WiBCIData.channelNames = {'Packet Number (n)',...
    'App Timestamp (us)',...
    'Sensor Timestamp (us)',...
    dataChannelNames{1},...
    dataChannelNames{2},...
    dataChannelNames{3},...
    dataChannelNames{4},...
    dataChannelNames{5},...
    dataChannelNames{6},...
    dataChannelNames{7},...
    dataChannelNames{8},...
    dataChannelNames{9},...
    dataChannelNames{10},...
    dataChannelNames{11},...
    dataChannelNames{12},...
    dataChannelNames{13},...
    dataChannelNames{14},...
    dataChannelNames{15},...
    dataChannelNames{16},...
    'AccX (mg)',...
    'AccY (mg)',...
    'AccZ (mg)',...
    'Event A',...
    'Event B'};


    function names = getChannelNames(fileTable, channelNums)
        namesCell = cellfun(@(x)strsplit(x, '(uV)'), fileTable.Properties.VariableNames(channelNums), 'UniformOutput', false);
        names = cellfun(@(x)strtrim(x{1}), namesCell, 'UniformOutput', false);
    end

    function [newMatrix, numMissing] = appendNans(dataMatrix)
        breaksAreNextTo = find(diff(dataMatrix(:, 1)) > 1);
        if(isempty(breaksAreNextTo))
            newMatrix = dataMatrix;
            numMissing = 0;
            return
        else
            firstBreakIsNextTo = breaksAreNextTo(1);
            lastCorrectPacketNumber = dataMatrix(firstBreakIsNextTo, 1);
            packetNumberAfterBreak = dataMatrix(firstBreakIsNextTo+1, 1);
            numMissingPackets = packetNumberAfterBreak - lastCorrectPacketNumber - 1;
            missingPacketsNums = lastCorrectPacketNumber+1 : packetNumberAfterBreak-1;
            missngPacketData = NaN .* ones(numMissingPackets, size(dataMatrix, 2));
            missngPacketData(:, 1) = missingPacketsNums;
            missngPacketData(:, 23:24) = zeros(length(missingPacketsNums), 2);

            dataBeforeMissingness = dataMatrix(1:firstBreakIsNextTo, :);
            dataAfterMissingness = dataMatrix(firstBreakIsNextTo+1:end, :);

            [postDataWithoutMissingness, missingCount] = appendNans(dataAfterMissingness);
            newMatrix = cat(1, dataBeforeMissingness , missngPacketData, postDataWithoutMissingness);
            numMissing = missingCount + numMissingPackets;
        end
    end
end

