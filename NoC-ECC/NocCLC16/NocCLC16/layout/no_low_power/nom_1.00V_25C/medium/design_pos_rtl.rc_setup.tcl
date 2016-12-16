#####################################################################
#
# RTL Compiler setup file
# Created by Encounter(R) RTL Compiler v11.10-s016_1
#   on 10/19/2016 08:54:45
#
#####################################################################


# This script is intended for use with RTL Compiler version v11.10-s016_1


# Remove Existing Design
###########################################################
if {[find -design /designs/RouterCC] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  rm /designs/RouterCC
}


# Libraries
###########################################################
set_attribute library {/soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_nom_1.00V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_wc_1.00V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_bc_0.95V_m40C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_nom_1.00V_1.80V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_1.25V_1.65V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_bc_1.05V_1.95V_m40C.lib {}} /

set_attribute lef_library {/soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.lef /soft64/design-kits/stm/65nm-cmos065_536/PRHS65_7.0.a/CADENCE/LEF/PRHS65_soc.lef /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/CADENCE/LEF/CORE65GPSVT_soc.lef /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/CADENCE/LEF/CLOCK65GPSVT_soc.lef /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/CADENCE/LEF/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_soc.lef /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_CORESUPPLY_50A_7M4X0Y2Z@7.0.c.UD5357/CADENCE/LEF/IO65LPHVT_CORESUPPLY_50A_7M4X0Y2Z_gaph.lef /soft64/design-kits/stm/65nm-cmos065_536/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_7.2/CADENCE/LEF/IO65LP_SF_BASIC_50A_ST_7M4X0Y2Z_soc.lef} /
set_attribute cap_table_file /soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable /


# Design
###########################################################
read_netlist -top RouterCC ./projetos/NocCLC16/layout/no_low_power/nom_1.00V_25C/medium/design_pos_rtl.v
source ./projetos/NocCLC16/layout/no_low_power/nom_1.00V_25C/medium/design_pos_rtl.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
###########################################################
# program version
if {"[string_representation [get_attribute program_version /]]" != "v11.10-s016_1"} {
   mesg_send [find -message /messages/PHYS/PHYS-91] "golden program_version: v11.10-s016_1  current program_version: [string_representation [get_attribute program_version /]]"
}
# license
if {"[string_representation [get_attribute startup_license /]]" != "Virtuoso_Digital_Implem"} {
   mesg_send [find -message /messages/PHYS/PHYS-91] "golden license: Virtuoso_Digital_Implem  current license: [string_representation [get_attribute startup_license /]]"
}
# slack
set _slk_ [get_attribute slack /designs/RouterCC]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "-71.9"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden slack: -71.9,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [get_attribute tns /designs/RouterCC]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "566"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden tns: 566,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [get_attribute cell_area /designs/RouterCC]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "82083"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden cell area: 82083,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [get_attribute net_area /designs/RouterCC]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "52455"} {
   mesg_send [find -message /messages/PHYS/PHYS-92] "golden net area: 52455,  current net area: $_net_area_"
}
unset _net_area_
