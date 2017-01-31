#------------------------------------------------------------------------------
# RTL script
#------------------------------------------------------------------------------
# Author: Douglas Roberto Guarani da Silva
#------------------------------------------------------------------------------

# Include Settings
# -----------------------------------------
include settings_rtl.tcl 

# Attributes
# -----------------------------------------
# Tool settings
set_attribute information_level $INFORMATION_LEVEL
set_attribute hdl_vhdl_read_version $VHDL_VERSION 

# Paths
set_attribute library $LIB_FILES 
set_attribute lef_library $LEF_FILES
set_attribute hdl_search_path $HDL_PATH
set_attribute cap_table_file $CAP_TABLE_FILE

# Power
set_attr hdl_track_filename_row_col true

# Synthesis
# -----------------------------------------
read_hdl -vhdl $HDL_FILES
elaborate $TOP_LEVEL
read_sdc constraints_pre_rtl.sdc

foreach is_low_power $LOW_POWER {
    foreach current_effort $EFFORT {
        foreach condition $OPERATING_CONDITION {
            set_attribute operating_conditions $condition
            if {$is_low_power == 1} then {
                set_attribute lp_insert_clock_gating true
                set root_path ${LAYOUT_PATH}/${LOW_POWER_PATH}/${condition}/${current_effort}
            } else {
                set_attribute lp_insert_clock_gating false
                set root_path ${LAYOUT_PATH}/${NO_LOW_POWER_PATH}/${condition}/${current_effort}
            }
            synthesize -to_generic -effort $current_effort
            synthesize -to_mapped -effort $current_effort
            # Reports
            # -----------------------------------------
            report power > ${root_path}/${REPORT_PATH}/${REPORT_POWER_FILE}
            report timing > ${root_path}/${REPORT_PATH}/${REPORT_TIMING_FILE}
            report area > ${root_path}/${REPORT_PATH}/${REPORT_AREA_FILE}
            report gates > ${root_path}/${REPORT_PATH}/${REPORT_GATES_FILE}
            if {$is_low_power == 1} then {
                report clock_gating > ${root_path}/${REPORT_PATH}/${REPORT_CLOCK_GATING_FILE}
            }
            # Export the design
            # -----------------------------------------
            write_sdf > ${root_path}/$SDF_FILE
            write_sdc > ${root_path}/$SDC_FILE
            write_design -encounter -basename ${root_path}/$DESIGN_POS_RTL
        }
    }
}
