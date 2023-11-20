function [EEG,DataTable] = loadExperimentAFile(filePath)
EEG = wibci2eeglab(filePath, 1);
WiBCIData = loadWiBCIData(filePath, 1);

DataTable = array2table(WiBCIData.channelData);
DataTable.Properties.VariableNames = WiBCIData.channelNames;
end