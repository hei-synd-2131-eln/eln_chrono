onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fpga_tb/reset_n
add wave -noupdate -format Logic /fpga_tb/clock
add wave -noupdate -format Logic /fpga_tb/testmode
add wave -noupdate -format Logic /fpga_tb/restart_n
add wave -noupdate -format Logic /fpga_tb/start_n
add wave -noupdate -format Logic /fpga_tb/stop_n
add wave -noupdate -format Logic /fpga_tb/sensor_n
add wave -noupdate -format Logic /fpga_tb/motoron1
add wave -noupdate -format Logic /fpga_tb/motoron2
add wave -noupdate -format Logic /fpga_tb/coil1_n
add wave -noupdate -format Logic /fpga_tb/coil2_n
add wave -noupdate -format Logic /fpga_tb/coil3_n
add wave -noupdate -format Logic /fpga_tb/coil4_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {210105 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
