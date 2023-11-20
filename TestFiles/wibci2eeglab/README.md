# wibci2eeglab

## Load WiBCI Data as EEGLAB Dataset

To load CSV files exported from the WiBCI app, use the `wibci2eeglab` function. EEGLAB should be loaded before using this function. An example is shown below.

```MATLAB
EEG = wibci2eeglab('Example Data/example_with_missing_packets.csv');
```

EEGLAB functions can be used directly on the EEG structure such as `pop_plottopo`. Or, the EEG structure can be saved as a EEGLAB dataset using the `pop_saveset` functions for later use.

## Abbreviations for Trigger Events

1. ST A, ST B: Software trigger A, B.
2. HT A, HT B: Hardware trigger A, B.

## Missing Data

### Source of missing data

WiBCI hardware uses Wifi to transmit data to the app. As Wifi is a wireless protocol with throughput and latency constraints, a realtime operation and 100% data integrity is challenging to achieve. Currently, WiBCI places greater emphasis on realtime operation while sacrificing data integrity to some extent. Therefore, it is possible that the recorded data has missing packets.

### What to do with the missing packets?

`wibci2eeglab` function automatically displays the percentage of missing packets and fills them using MATLAB's `fillmissing` function with the `pchip` method. For more details, see "help fillmissing" in MATLAB. If the automated fill functionality is not required, call `wibci2eeglab` as `wibci2eeglab(filePath, 0)`.

## Experiment A

Data saved with "Experiment A" montage can be loaded with `loadExperimentAFile` function and plotted for a quick check with `quickViewExperimentAFile` function.
