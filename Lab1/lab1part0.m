
%% Parameters
SampleRate = 1e6;
Frames = 20;
SamplesPerFrame = 2^14;

%% Generate test sinewave
amplitude = 1; frequency = 1e4;
swv1 = dsp.SineWave(amplitude, frequency);
swv1.SampleRate = SampleRate;
swv1.SamplesPerFrame = SamplesPerFrame;
swv1.ComplexOutput = true;
y = swv1();

%% Show  AGC changing
rx = sdrrx('Pluto','SamplesPerFrame',SamplesPerFrame);
rx.GainSource = 'AGC Slow Attack';
tx = sdrtx('Pluto','Gain',-20);
tx.transmitRepeat(y);

z = zeros(Frames,SamplesPerFrame);

for k=1:Frames
    z(k,:) = rx();
    % Update gain halfway through
    if k==floor(Frames/2)
        tx.Gain = 0;
        tx.transmitRepeat(y);
        disp('Gain Change');
    end
end


%% Plot
figure(1);
z = z.';
plot(real(z(:)));
xlabel('Samples');ylabel('Amplitude');grid on;

