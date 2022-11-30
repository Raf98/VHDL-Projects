onerror {quit -f}
vlib work
vlog -work work bombaNova.vo
vlog -work work bombaNova.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.bombaNova_vlg_vec_tst
vcd file -direction bombaNova.msim.vcd
vcd add -internal bombaNova_vlg_vec_tst/*
vcd add -internal bombaNova_vlg_vec_tst/i1/*
add wave /*
run -all
