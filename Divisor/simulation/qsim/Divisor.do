onerror {quit -f}
vlib work
vlog -work work Divisor.vo
vlog -work work Divisor.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Divisor_vlg_vec_tst
vcd file -direction Divisor.msim.vcd
vcd add -internal Divisor_vlg_vec_tst/*
vcd add -internal Divisor_vlg_vec_tst/i1/*
add wave /*
run -all
