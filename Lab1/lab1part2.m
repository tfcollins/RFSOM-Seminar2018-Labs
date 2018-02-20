%% Create complex sine wave
amplitude = 1; frequency = 1e3;
swv1 = dsp.SineWave(amplitude, frequency);
swv1.SampleRate = 1e6;
swv1.SamplesPerFrame = 2^14; % Amount of data produced per step call
swv1.ComplexOutput = true;
y = swv1();

%% CHANGE ME HERE

% Overflow only in SA
SampleRate = 4.5e6;
SamplesPerRXFrame = 2^16;
FramesToCollect = 1e2;

%% Set up radio and capture some data with processing out of loop
rx = sdrrx('Pluto','SamplesPerFrame',SamplesPerRXFrame,...
    'BasebandSampleRate',SampleRate);
tx = sdrtx('Pluto','Gain',-30,...
    'BasebandSampleRate',SampleRate);
tx.transmitRepeat(y);
% Get data from radio
sa = dsp.SpectrumAnalyzer();
saved = zeros(FramesToCollect*SamplesPerRXFrame,1);
ofe = 0;
for g=1:SamplesPerRXFrame:FramesToCollect*SamplesPerRXFrame
    [data1,~,of] = rx();
    
    saved(g:g+SamplesPerRXFrame-1) = data1;
    
    if of
        ofe = ofe + 1;
    end
end
% Visualize
for g=1:SamplesPerRXFrame:FramesToCollect*SamplesPerRXFrame
    sa(saved(g:g+SamplesPerRXFrame-1));
end

fprintf('(OUTLOOP) Overflow events: %d of %d\n',ofe,FramesToCollect);
clear rx tx;

%% Set up radio and capture some data with processing in loop
rx = sdrrx('Pluto','SamplesPerFrame',SamplesPerRXFrame,...
    'BasebandSampleRate',SampleRate);
tx = sdrtx('Pluto','Gain',-30,...
    'BasebandSampleRate',SampleRate);
tx.transmitRepeat(y);
% Get data from radio
sa = dsp.SpectrumAnalyzer();
sa(complex(zeros(SamplesPerRXFrame,1,'int16')));
ofe = 0;
for g=1:FramesToCollect
    [data1,~,of] = rx();
    
    if of
        ofe = ofe + 1;
    end
    sa(data1);
end

fprintf('(INLOOP) Overflow events: %d of %d\n',ofe,FramesToCollect);

clear rx tx;
