#------------------------------------------------------------------------------
# VLSI II - T1_1
# Professor: Leticia Maria Bolzani Pohls
#------------------------------------------------------------------------------
# Group: 4
# Names: Douglas Roberto Guarani da Silva
#        Mauricio Cecilio Magnaguagno
#------------------------------------------------------------------------------
# File Description: Pre RTL constraints
#------------------------------------------------------------------------------

include settings_rtl.tcl

# Timing
create_clock -name $CLOCK_NAME -period $CLOCK_PERIOD [find / -port $CLOCK_NAME]
