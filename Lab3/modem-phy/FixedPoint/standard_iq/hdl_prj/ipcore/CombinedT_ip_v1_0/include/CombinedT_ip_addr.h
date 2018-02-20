/*
 * File Name:         hdl_prj\ipcore\CombinedT_ip_v1_0\include\CombinedT_ip_addr.h
 * Description:       C Header File
 * Created:           2018-02-01 11:49:59
*/

#ifndef COMBINEDT_IP_H_
#define COMBINEDT_IP_H_

#define  IPCore_Reset_CombinedT_ip       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_CombinedT_ip      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_CombinedT_ip   0x8  //contains unique IP timestamp (yymmddHHMM): 1802011149

#endif /* COMBINEDT_IP_H_ */
