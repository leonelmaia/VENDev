#------------------------------------------------------------------------------
# RTL Settings
#------------------------------------------------------------------------------
# Author: Douglas Roberto Guarani da Silva
#------------------------------------------------------------------------------

# Tool Settings
# -----------------------------------------
set INFORMATION_LEVEL 9
set VHDL_VERSION 1993

# HDL paths
# -----------------------------------------
set HDL_PATH ./projetos/NocCLC16
#set HDL_FILES {Thor_package.vhd Table_package.vhd Thor_RM.vhd Thor_switchcontrol.vhd Thor_crossbar.vhd Thor_buffer.vhd Encoder.vhd Decoder.vhd RouterCC.vhd NOC.vhd}
set HDL_FILES {Thor_package.vhd Table_package.vhd Thor_RM.vhd Thor_switchcontrol.vhd Thor_crossbar.vhd Thor_buffer.vhd Encoder.vhd Decoder.vhd RouterCC.vhd}

# Project Specific
# -----------------------------------------
#set TOP_LEVEL NOC
set TOP_LEVEL RouterCC
set CLOCK_NAME clock
set CLOCK_PERIOD 2

# Libraries Paths
# -----------------------------------------
set DK_PATH  "/soft64/design-kits/stm/65nm-cmos065_536" 

set LIB_FILES "${DK_PATH}/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib \
               ${DK_PATH}/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_nom_1.00V_25C.lib \
               ${DK_PATH}/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib \
               ${DK_PATH}/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_wc_1.00V_125C.lib \
               ${DK_PATH}/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib \
               ${DK_PATH}/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_bc_0.95V_m40C.lib \
               ${DK_PATH}/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_nom_1.00V_1.80V_25C.lib \
               ${DK_PATH}/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_1.25V_1.65V_125C.lib \
               ${DK_PATH}/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_bc_1.05V_1.95V_m40C.lib"
               
set LEF_FILES "${DK_PATH}/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef \
               ${DK_PATH}/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef \
               ${DK_PATH}/CORE65GPSVT_5.1/CADENCE/LEF/CORE65GPSVT_soc.lef \        
               ${DK_PATH}/CLOCK65GPSVT_3.1/CADENCE/LEF/CLOCK65GPSVT_soc.lef \
               ${DK_PATH}/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/CADENCE/LEF/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_soc.lef \
               ${DK_PATH}/IO65LPHVT_CORESUPPLY_50A_7M4X0Y2Z@7.0.c.UD5357/CADENCE/LEF/IO65LPHVT_CORESUPPLY_50A_7M4X0Y2Z_gaph.lef \
               ${DK_PATH}/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef"
               
set CAP_TABLE_FILE ${DK_PATH}/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable

# Electrical Properties
# -----------------------------------------
# set OPERATING_CONDITION {nom_1.00V_25C wc_1.00V_125C bc_0.95V_m40C}
set OPERATING_CONDITION {nom_1.00V_25C}

# Low Power
# -----------------------------------------
set LOW_POWER_PATH low_power
set NO_LOW_POWER_PATH no_low_power
set LOW_POWER {0}


# Synthesis Option
# -----------------------------------------
# set EFFORT {low medium high}
set EFFORT {medium}

# Report Files
# -----------------------------------------
set REPORT_PATH reports
set REPORT_POWER_FILE report_power.txt
set REPORT_TIMING_FILE report_timing.txt
set REPORT_AREA_FILE report_area.txt
set REPORT_GATES_FILE report_gates.txt
set REPORT_CLOCK_GATING_FILE report_clock_gating.txt

# Export Files
# -----------------------------------------
set LAYOUT_PATH ${HDL_PATH}/layout
set SDC_FILE constraints_pos_rtl.sdc
set SDF_FILE timing_pos_rtl.sdf
set DESIGN_POS_RTL design_pos_rtl

