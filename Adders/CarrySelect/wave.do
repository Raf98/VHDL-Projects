onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /carryselecttb/num
add wave -noupdate /carryselecttb/clock
add wave -noupdate -radix unsigned /carryselecttb/a
add wave -noupdate -radix unsigned /carryselecttb/b
add wave -noupdate -radix hexadecimal /carryselecttb/s
add wave -noupdate /carryselecttb/cLast
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {98 ps} {106 ps}
