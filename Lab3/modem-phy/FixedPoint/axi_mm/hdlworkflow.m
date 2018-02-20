%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.3 (R2017b) at 18:06:51 on 01/02/2018
% This script was generated using the following parameter values:
%     Filename  : 'C:\Seminar\Lab3\modem-phy\FixedPoint\axi_mm\hdlworkflow_current.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'combinedTxRx_AXIMM/Combined TX and RX'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','combinedTxRx_AXIMM/Combined TX and RX');
%--------------------------------------------------------------------------

%% Load the Model
load_system('combinedTxRx_AXIMM');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('combinedTxRx_AXIMM/Combined TX and RX');

%% Model HDL Parameters
%% Set Model 'combinedTxRx_AXIMM' HDL parameters
hdlset_param('combinedTxRx_AXIMM', 'HDLSubsystem', 'combinedTxRx_AXIMM/Combined TX and RX');
hdlset_param('combinedTxRx_AXIMM', 'ReferenceDesign', 'Receive and transmit path');
hdlset_param('combinedTxRx_AXIMM', 'ReferenceDesignParameter', {'boardName','ccfmc_lvds','project','adrv9361z7035','mw_hdl_dir','ipcore/mw','ad_hdl_dir','ipcore/adi','variant','rxtx','mw_board_name','adrv9361z7035','mw_adi_boardname','adrv9361z7035/ccfmc_lvds'});
hdlset_param('combinedTxRx_AXIMM', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('combinedTxRx_AXIMM', 'SynthesisToolChipFamily', 'Zynq');
hdlset_param('combinedTxRx_AXIMM', 'SynthesisToolDeviceName', 'xc7z035i');
hdlset_param('combinedTxRx_AXIMM', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('combinedTxRx_AXIMM', 'SynthesisToolSpeedValue', '-2L');
hdlset_param('combinedTxRx_AXIMM', 'TargetDirectory', 'hdl_prj\hdlsrc');
hdlset_param('combinedTxRx_AXIMM', 'TargetFrequency', 20);
hdlset_param('combinedTxRx_AXIMM', 'TargetPlatform', 'ADI RF SOM [LibIIO]');
hdlset_param('combinedTxRx_AXIMM', 'Workflow', 'IP Core Generation');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ValidInTx', 'IOInterface', 'DMA Tx Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ValidInTx', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/rInTx', 'IOInterface', 'DMA Tx I1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/rInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/iInTx', 'IOInterface', 'DMA Tx Q1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/iInTx', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioR', 'IOInterface', 'Baseband Rx I1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioI', 'IOInterface', 'Baseband Rx Q1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioValidIn', 'IOInterface', 'Baseband Rx Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromRadioValidIn', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/LoopBW', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/LoopBW', 'IOInterfaceMapping', 'x"100"');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/EQmu', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/EQmu', 'IOInterfaceMapping', 'x"104"');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/SelectScope', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/SelectScope', 'IOInterfaceMapping', 'x"108"');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/SelectError', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/SelectError', 'IOInterfaceMapping', 'x"10C"');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/re', 'IOInterface', 'Rx data I1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/re', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Im', 'IOInterface', 'Rx data Q1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Im', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Enable', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Enable', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/FRLoopBW', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/FRLoopBW', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/EQmu', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/EQmu', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Scope Select', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/Scope Select', 'IOInterfaceMapping', '[0]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/DebugSelector', 'IOInterface', 'Rx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/DebugSelector', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/bytesOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/sync', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/sync', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/payloadLenOut', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/dataRe', 'IOInterface', 'Rx data I1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/dataRe', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/dataIm', 'IOInterface', 'Rx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/dataIm', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validIQ', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validIQ', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/crcErr', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/crcErr', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validCRC', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/validCRC', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/endFlag', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/endFlag', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/DebugSelection', 'IOInterface', 'Rx data Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Receiver HDL/DebugSelection', 'IOInterfaceMapping', '[0]');

% Set SubSystem HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/bytesIn', 'IOInterface', 'Tx data I1 In [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/bytesIn', 'IOInterfaceMapping', '[0:15]');

% Set Inport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/validIn', 'IOInterface', 'Tx data Valid In');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/validIn', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Packet Generation/trueData', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Packet Generation/trueData', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/real', 'IOInterface', 'Tx data I1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/real', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/imag', 'IOInterface', 'Tx data Q1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/imag', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/validOut', 'IOInterface', 'Tx data Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/validOut', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Need Data', 'IOInterface', 'No Interface Specified');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/Transmitter HDL/Need Data', 'IOInterfaceMapping', '');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioR', 'IOInterface', 'Baseband Tx I1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioR', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioI', 'IOInterface', 'Baseband Tx Q1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioI', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioValid', 'IOInterface', 'Baseband Tx Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/ToRadioValid', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPR', 'IOInterface', 'DMA Rx I1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPR', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPI', 'IOInterface', 'DMA Rx Q1 Out [0:15]');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPI', 'IOInterfaceMapping', '[0:15]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPvalid', 'IOInterface', 'DMA Rx Valid Out');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/FromIPvalid', 'IOInterfaceMapping', '[0]');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/packetCount', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/packetCount', 'IOInterfaceMapping', 'x"110"');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/selectedError', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/selectedError', 'IOInterfaceMapping', 'x"114"');

% Set Outport HDL parameters
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/packetLen', 'IOInterface', 'AXI4-Lite');
hdlset_param('combinedTxRx_AXIMM/Combined TX and RX/packetLen', 'IOInterfaceMapping', 'x"118"');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','IP Core Generation');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj';
hWC.ReferenceDesignToolVersion = '2016.4';
hWC.IgnoreToolVersionMismatch = false;

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndIPCore = true;
hWC.RunTaskCreateProject = true;
hWC.RunTaskGenerateSoftwareInterfaceModel = false;
hWC.RunTaskBuildFPGABitstream = true;
hWC.RunTaskProgramTargetDevice = false;

% Set properties related to 'RunTaskGenerateRTLCodeAndIPCore' Task
hWC.IPCoreRepository = '';
hWC.GenerateIPCoreReport = true;

% Set properties related to 'RunTaskCreateProject' Task
hWC.Objective = hdlcoder.Objective.None;
hWC.AdditionalProjectCreationTclFiles = '';
hWC.EnableIPCaching = false;

% Set properties related to 'RunTaskGenerateSoftwareInterfaceModel' Task
hWC.OperatingSystem = 'Linux';

% Set properties related to 'RunTaskBuildFPGABitstream' Task
hWC.RunExternalBuild = true;
hWC.TclFileForSynthesisBuild = hdlcoder.BuildOption.Default;
hWC.CustomBuildTclFile = '';

% Set properties related to 'RunTaskProgramTargetDevice' Task
hWC.ProgrammingMethod = hdlcoder.ProgrammingMethod.Download;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('combinedTxRx_AXIMM/Combined TX and RX', hWC);
