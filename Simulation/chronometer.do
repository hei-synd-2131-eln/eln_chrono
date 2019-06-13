onerror {resume}
set NumericStdNoWarnings 1
quietly WaveActivateNextPane {} 0
add wave -noupdate /chronometer_tb/reset
add wave -noupdate /chronometer_tb/clock
add wave -noupdate /chronometer_tb/testmode
add wave -noupdate -divider {Buttons & sensor}
add wave -noupdate /chronometer_tb/restart
add wave -noupdate /chronometer_tb/start
add wave -noupdate /chronometer_tb/stop
add wave -noupdate /chronometer_tb/sensor
add wave -noupdate -divider Internals
add wave -noupdate /chronometer_tb/i_dut/direction
add wave -noupdate /chronometer_tb/i_dut/en1hz
add wave -noupdate /chronometer_tb/i_dut/enstep
add wave -noupdate /chronometer_tb/i_dut/i_ctrl/current_state
add wave -noupdate /chronometer_tb/i_dut/resettime
add wave -noupdate /chronometer_tb/i_dut/tickdone
add wave -noupdate /chronometer_tb/i_dut/stepcoil
add wave -noupdate -radix unsigned -subitemconfig {/chronometer_tb/i_dut/amplitude(3) {-radix unsigned} /chronometer_tb/i_dut/amplitude(2) {-radix unsigned} /chronometer_tb/i_dut/amplitude(1) {-radix unsigned} /chronometer_tb/i_dut/amplitude(0) {-radix unsigned}} /chronometer_tb/i_dut/amplitude
add wave -noupdate -divider Motor
add wave -noupdate /chronometer_tb/coil1
add wave -noupdate /chronometer_tb/coil2
add wave -noupdate /chronometer_tb/coil3
add wave -noupdate /chronometer_tb/coil4
add wave -noupdate -divider LCD
add wave -noupdate -radix ascii /chronometer_tb/i_dut/character
add wave -noupdate /chronometer_tb/i_dut/send
add wave -noupdate /chronometer_tb/i_dut/busy
add wave -noupdate /chronometer_tb/cs1_n
add wave -noupdate /chronometer_tb/scl
add wave -noupdate /chronometer_tb/si
add wave -noupdate /chronometer_tb/a0
add wave -noupdate /chronometer_tb/rst_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
WaveRestoreZoom {0 ps} {2048 us}
