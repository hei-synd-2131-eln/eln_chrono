onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcdserializer_tb/reset
add wave -noupdate /lcdserializer_tb/clock
add wave -noupdate -divider Control
add wave -noupdate -radix hexadecimal /lcdserializer_tb/data
add wave -noupdate /lcdserializer_tb/send
add wave -noupdate /lcdserializer_tb/busy
add wave -noupdate -divider Internals
add wave -noupdate /lcdserializer_tb/i_dut/resetdone
add wave -noupdate /lcdserializer_tb/i_dut/sclen
add wave -noupdate /lcdserializer_tb/i_dut/scl_int
add wave -noupdate -radix unsigned /lcdserializer_tb/i_dut/datacounter
add wave -noupdate -divider {LCD interface}
add wave -noupdate /lcdserializer_tb/rst_n
add wave -noupdate /lcdserializer_tb/a0
add wave -noupdate /lcdserializer_tb/cs_n
add wave -noupdate /lcdserializer_tb/scl
add wave -noupdate /lcdserializer_tb/si
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 225
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {26250 ns}
