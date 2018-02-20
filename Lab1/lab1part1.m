%% Create complex sine wave
amplitude = 1; frequency = 1e3;
swv1 = dsp.SineWave(amplitude, frequency);
swv1.SampleRate = 1e6;
swv1.SamplesPerFrame = 2^14; % Amount of data produced per step call
swv1.ComplexOutput = true;
y = swv1();

%% Set up radio and capture some data
rx = sdrrx('Pluto'); rx.SamplesPerFrame = 2^16;
tx = sdrtx('Pluto'); tx.transmitRepeat(y);
tx.Gain = -30;
% Get data from radio
data1 = rx();
data2 = rx();

%% Plots
figure(1);
plot(real(data1));hold on;
plot(real(data2));hold off;
xlabel('Samples'); ylabel('Amplitude');