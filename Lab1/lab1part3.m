clear all;

%% Generate QPSK Frame with Modem Design Configuration
qpskFrames = generateFrame('PayloadBytes',200,'Packets',10);

%% CHANGE ME HERE
SampleRate = 1e6;
SamplesPerRXFrame = 2^16;
FramesToCollect = 10;
FrequencyOffset = 0;

%% Set up radio and capture some data
rx = sdrrx('Pluto','SamplesPerFrame',SamplesPerRXFrame,...
    'BasebandSampleRate',SampleRate,'OutputDataType','double');
tx = sdrtx('Pluto','Gain',-30,...
    'BasebandSampleRate',SampleRate);
tx.CenterFrequency = tx.CenterFrequency + FrequencyOffset;
tx.transmitRepeat(qpskFrames);
% Get data from radio
saved = zeros(FramesToCollect*SamplesPerRXFrame,1);
ofe = 0;
for g=1:SamplesPerRXFrame:FramesToCollect*SamplesPerRXFrame
    [data1,len,of] = rx();
    saved(g:g+SamplesPerRXFrame-1) = data1;
    if of % Count overflows
        ofe = ofe + 1;
    end
end
fprintf('Overflow events: %d of %d\n',ofe,FramesToCollect);

%% Timing Synchronization
fprintf('Performing Timing Synchronization\n');
% Match filter signal
hRxFilt = comm.RaisedCosineReceiveFilter( ...
    'RolloffFactor',0.5, ...
    'FilterSpanInSymbols',8, ...
    'InputSamplesPerSymbol',4, ...
    'DecimationFactor',1);
saved = hRxFilt(saved);
% Time sync data
ss = comm.SymbolSynchronizer('SamplesPerSymbol',4,...
    'TimingErrorDetector','Gardner (non-data-aided)');
ss.NormalizedLoopBandwidth = 0.1;
savedPost = ss(saved);

%% Insert Carrier Synchronization here
%fprintf('Performing Carrier Synchronization\n');
%cs = comm.CarrierSynchronizer('SamplesPerSymbol',1);
%savedPost = cs(savedPost);

%% Visualize Corrected signal
% Configure Constellation Diagrams
sa1 = comm.ConstellationDiagram('Name','Pre Sync');
sa1.SamplesPerSymbol = 4;
sa2 = comm.ConstellationDiagram('Name','Post Sync');
sa2.SamplesPerSymbol = 1;
sa2.Position = sa1.Position + [500 0 0 0];
% Reduce data visualized each step
SamplesPerRXFrame = SamplesPerRXFrame/4;

for g=1:SamplesPerRXFrame:length(savedPost)-SamplesPerRXFrame
    sa1(saved(g:g+SamplesPerRXFrame-1));
    sa2(savedPost(g:g+SamplesPerRXFrame-1)); 
    pause(0.1);
end

clear rx tx;
