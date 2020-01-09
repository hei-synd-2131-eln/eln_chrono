onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Reset and clock} /chronometer_tb/reset
add wave -noupdate -expand -group {Reset and clock} /chronometer_tb/clock
add wave -noupdate /chronometer_tb/testMode
add wave -noupdate -divider {Buttons & sensor}
add wave -noupdate /chronometer_tb/restart
add wave -noupdate /chronometer_tb/sensor
add wave -noupdate /chronometer_tb/start
add wave -noupdate /chronometer_tb/stop
add wave -noupdate /chronometer_tb/button4
add wave -noupdate -divider Internals
add wave -noupdate /chronometer_tb/I_DUT/direction
add wave -noupdate /chronometer_tb/I_DUT/en1Hz
add wave -noupdate /chronometer_tb/I_DUT/enStep
add wave -noupdate /chronometer_tb/I_DUT/I_ctrl/current_state
add wave -noupdate /chronometer_tb/I_DUT/resetTime
add wave -noupdate /chronometer_tb/I_DUT/tickDone
add wave -noupdate /chronometer_tb/I_DUT/stepCoil
add wave -noupdate -radix unsigned /chronometer_tb/I_DUT/amplitude
add wave -noupdate -divider Motor
add wave -noupdate /chronometer_tb/coil1
add wave -noupdate /chronometer_tb/coil2
add wave -noupdate /chronometer_tb/coil3
add wave -noupdate /chronometer_tb/coil4
add wave -noupdate -group LCD -radix ascii /chronometer_tb/I_DUT/character
add wave -noupdate -group LCD /chronometer_tb/CS1_n
add wave -noupdate -group LCD /chronometer_tb/SCL
add wave -noupdate -group LCD /chronometer_tb/SI
add wave -noupdate -group LCD /chronometer_tb/A0
add wave -noupdate -group LCD /chronometer_tb/RST_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 236
configure wave -valuecolwidth 44
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {525 us}
