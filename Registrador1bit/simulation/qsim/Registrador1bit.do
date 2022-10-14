onerror {quit -f}
vlib work
vlog -work work Registrador1bit.vo
vlog -work work Registrador1bit.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Registrador1bit_vlg_vec_tst
vcd file -direction Registrador1bit.msim.vcd
vcd add -internal Registrador1bit_vlg_vec_tst/*
vcd add -internal Registrador1bit_vlg_vec_tst/i1/*
add wave /*
run -all
