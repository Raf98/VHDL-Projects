onerror {quit -f}
vlib work
vlog -work work Contador3bits.vo
vlog -work work Contador3bits.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Contador3bits_vlg_vec_tst
vcd file -direction Contador3bits.msim.vcd
vcd add -internal Contador3bits_vlg_vec_tst/*
vcd add -internal Contador3bits_vlg_vec_tst/i1/*
add wave /*
run -all
