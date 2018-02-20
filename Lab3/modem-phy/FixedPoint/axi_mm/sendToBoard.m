dev = sdrdev('ZynqRadioLibIIO');

%downloadImage(dev, 'SDCardLocation', '/media/tcollins/25A9-A7FD/',...
%    'BoardName', 'ADI RF SOM')

downloadImage(dev,'BoardName', 'ADI RF SOM', ...
    'FPGAImage', 'hdl_prj/system_top.bit')
