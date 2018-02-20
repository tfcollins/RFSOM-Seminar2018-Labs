%clc;
radioIP = 'ip:192.168.3.2';
%% Writers
% Frequency Recovery Loop Bandwidth
w1 = matlabshared.libiio.aximm.write('uri',radioIP);
w1.AddressOffset = hex2dec('100');
w1.HardwareDataType='int16';
% Equalizer Step Size
w2 = matlabshared.libiio.aximm.write('uri',radioIP);
w2.AddressOffset = hex2dec('104');
w2.HardwareDataType='int16';
% IQ Scope Selection
w3 = matlabshared.libiio.aximm.write('uri',radioIP);
w3.AddressOffset = hex2dec('108');
w3.HardwareDataType='int8';
% Debug Status Signal Selection
w4 = matlabshared.libiio.aximm.write('uri',radioIP);
w4.AddressOffset = hex2dec('10C');
w4.HardwareDataType='int8';

%% Readers
% Packets Received Count
r1 = matlabshared.libiio.aximm.read('uri',radioIP);
r1.AddressOffset = hex2dec('110');
% Selected Error Signal
r2 = matlabshared.libiio.aximm.read('uri',radioIP);
r2.AddressOffset = hex2dec('114');
% Last packet length received
r3 = matlabshared.libiio.aximm.read('uri',radioIP);
r3.AddressOffset = hex2dec('118');

%% Writes
LoopBW = int16(40); %[1 128] Valid
w1(LoopBW);
EQmu = int16(300); % Value Inverted internally
w2(EQmu);
Scope = int8(2); % [1 4] Valid
w3(Scope);

%% Continuously read registers
clc;
for k=1:3
    % Check Timing PLL lock
    Error = int8(1);% Select Error index of interest
    w4(Error);
    TimingLocked = r2();
    % Check peaks found by detector
    Error = int8(2);% Select Error index of interest
    w4(Error);
    PeaksFound = r2();
    % Check Frequency PLL lock
    Error = int8(3);% Select Error index of interest
    w4(Error);
    FreqLoopLock = r2();
    % Check direct registers
    numPacketsReceived = r1();
    payloadLen = r3();
    % Display
    table(numPacketsReceived,payloadLen,TimingLocked,FreqLoopLock,...
        PeaksFound)
    pause(1);
end



