onerror {resume}
set NumericStdNoWarnings 1
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcdcontroller_tb/reset
add wave -noupdate /lcdcontroller_tb/clock
add wave -noupdate -divider Controller
add wave -noupdate -radix ascii /lcdcontroller_tb/ascii
add wave -noupdate -radix hexadecimal /lcdcontroller_tb/ascii
add wave -noupdate /lcdcontroller_tb/send
add wave -noupdate /lcdcontroller_tb/busy
add wave -noupdate -divider {Font Encoder}
add wave -noupdate /lcdcontroller_tb/i_dut/i_font/fontdisplaystate
add wave -noupdate -format Analog-Step -height 20 -max 6.0 -radix unsigned /lcdcontroller_tb/i_dut/i_font/columncounter
add wave -noupdate -height 20 -radix unsigned /lcdcontroller_tb/i_dut/i_font/columncounter
add wave -noupdate -radix unsigned -subitemconfig {/lcdcontroller_tb/i_dut/i_font/pixeloffset(5) {-radix unsigned} /lcdcontroller_tb/i_dut/i_font/pixeloffset(4) {-radix unsigned} /lcdcontroller_tb/i_dut/i_font/pixeloffset(3) {-radix unsigned} /lcdcontroller_tb/i_dut/i_font/pixeloffset(2) {-height 15 -radix unsigned} /lcdcontroller_tb/i_dut/i_font/pixeloffset(1) {-height 15 -radix unsigned} /lcdcontroller_tb/i_dut/i_font/pixeloffset(0) {-height 15 -radix unsigned}} /lcdcontroller_tb/i_dut/i_font/pixeloffset
add wave -noupdate -radix hexadecimal -subitemconfig {/lcdcontroller_tb/i_dut/pixeldata(47) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(46) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(45) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(44) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(43) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(42) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(41) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(40) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(39) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(38) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(37) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(36) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(35) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(34) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(33) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(32) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(31) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(30) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(29) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(28) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(27) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(26) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(25) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(24) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(23) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(22) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(21) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(20) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(19) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(18) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(17) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(16) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(15) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(14) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(13) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(12) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(11) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(10) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(9) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(8) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(7) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(6) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(5) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(4) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(3) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(2) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(1) {-radix hexadecimal} /lcdcontroller_tb/i_dut/pixeldata(0) {-radix hexadecimal}} /lcdcontroller_tb/i_dut/pixeldata
add wave -noupdate -radix hexadecimal /lcdcontroller_tb/i_dut/lcddata1
add wave -noupdate -divider Initialization
add wave -noupdate -divider Serializer
add wave -noupdate -radix hexadecimal /lcdcontroller_tb/i_dut/lcddata
add wave -noupdate -radix ascii -subitemconfig {/lcdcontroller_tb/i_dut/lcddata(8) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(7) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(6) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(5) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(4) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(3) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(2) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(1) {-radix hexadecimal} /lcdcontroller_tb/i_dut/lcddata(0) {-radix hexadecimal}} /lcdcontroller_tb/i_dut/lcddata
add wave -noupdate /lcdcontroller_tb/i_dut/lcdsend
add wave -noupdate /lcdcontroller_tb/i_dut/lcdbusy
add wave -noupdate -divider {LCD interface}
add wave -noupdate /lcdcontroller_tb/rst_n
add wave -noupdate /lcdcontroller_tb/a0
add wave -noupdate /lcdcontroller_tb/cs1_n
add wave -noupdate /lcdcontroller_tb/scl
add wave -noupdate /lcdcontroller_tb/si
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 272
configure wave -valuecolwidth 58
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
WaveRestoreZoom {0 ps} {31500 ns}
