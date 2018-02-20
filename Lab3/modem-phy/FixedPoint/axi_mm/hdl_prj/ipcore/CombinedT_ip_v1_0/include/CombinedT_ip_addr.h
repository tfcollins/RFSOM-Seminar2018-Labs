/*
 * File Name:         hdl_prj\ipcore\CombinedT_ip_v1_0\include\CombinedT_ip_addr.h
 * Description:       C Header File
 * Created:           2018-02-01 18:12:15
*/

#ifndef COMBINEDT_IP_H_
#define COMBINEDT_IP_H_

#define  IPCore_Reset_CombinedT_ip         0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_CombinedT_ip        0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_CombinedT_ip     0x8  //contains unique IP timestamp (yymmddHHMM): 1802011812
#define  LoopBW_Data_CombinedT_ip          0x100  //data register for Inport LoopBW
#define  EQmu_Data_CombinedT_ip            0x104  //data register for Inport EQmu
#define  SelectScope_Data_CombinedT_ip     0x108  //data register for Inport SelectScope
#define  SelectError_Data_CombinedT_ip     0x10C  //data register for Inport SelectError
#define  packetCount_Data_CombinedT_ip     0x110  //data register for Outport packetCount
#define  selectedError_Data_CombinedT_ip   0x114  //data register for Outport selectedError
#define  packetLen_Data_CombinedT_ip       0x118  //data register for Outport packetLen

#endif /* COMBINEDT_IP_H_ */
