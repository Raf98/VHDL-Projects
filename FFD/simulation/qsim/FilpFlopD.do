onerror {quit -f}
vlib work
vlog -work work FilpFlopD.vo
vlog -work work FilpFlopD.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.FlipFlopD_vlg_vec_tst
vcd file -direction FilpFlopD.msim.vcd
vcd add -internal FlipFlopD_vlg_vec_tst/*
vcd add -internal FlipFlopD_vlg_vec_tst/i1/*
add wave /*
run -all
