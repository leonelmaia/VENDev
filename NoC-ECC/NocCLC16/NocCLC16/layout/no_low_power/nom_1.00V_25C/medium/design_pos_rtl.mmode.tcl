create_library_set -name default_library_set -timing {/soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_nom_1.00V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_nom_1.00V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_wc_1.00V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_wc_1.00V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/CORE65GPSVT_5.1/libs/CORE65GPSVT_bc_0.95V_m40C.lib /soft64/design-kits/stm/65nm-cmos065_536/CLOCK65GPSVT_3.1/libs/CLOCK65GPSVT_bc_0.95V_m40C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_nom_1.00V_1.80V_25C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_wc_1.25V_1.65V_125C.lib /soft64/design-kits/stm/65nm-cmos065_536/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_7.0/libs/IO65LPHVT_SF_1V8_50A_7M4X0Y2Z_bc_1.05V_1.95V_m40C.lib}
create_rc_corner -name _default_rc_corner_ -T 25.0
update_rc_corner -name _default_rc_corner_ -cap_table /soft64/design-kits/stm/65nm-cmos065_536/EncounterTechnoKit_cmos065_7m4x0y2z_AP@5.3.1/TECH/cmos065_7m4x0y2z_AP_Worst.captable
create_delay_corner -name _default_delay_corner_ -library_set default_library_set -opcond nom_1.00V_25C  -opcond_library CORE65GPSVT -rc_corner _default_rc_corner_
create_constraint_mode -name _default_constraint_mode_ -sdc_files {./projetos/NocCLC16/layout/no_low_power/nom_1.00V_25C/medium/design_pos_rtl._default_constraint_mode_.sdc}
 
create_analysis_view -name _default_view_  -constraint_mode _default_constraint_mode_ -delay_corner _default_delay_corner_
 
 
set_analysis_view -setup _default_view_  -hold _default_view_
 
