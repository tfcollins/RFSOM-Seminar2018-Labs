%dev = sdrdev('ZC706 and FMCOMMS2/3/4');
%downloadImage(dev,'FPGAImage','hdl_prj_hwi_hsp/vivado_ip_prj/vivado_prj.runs/impl_1/system_wrapper.bit')
dev = sdrdev('ADI RF SOM');
downloadImage(dev,'FPGAImage','hdl_prj/system_wrapper.bit')
