onerror {quit -f}
vlib work
vlog -work work FlipFlopJK.vo
vlog -work work FlipFlopJK.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.FlipFlopJK_vlg_vec_tst
vcd file -direction FlipFlopJK.msim.vcd
vcd add -internal FlipFlopJK_vlg_vec_tst/*
vcd add -internal FlipFlopJK_vlg_vec_tst/i1/*
add wave /*
run -all
