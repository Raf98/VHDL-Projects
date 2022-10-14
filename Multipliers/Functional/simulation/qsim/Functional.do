onerror {quit -f}
vlib work
vlog -work work Functional.vo
vlog -work work Functional.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Functional_vlg_vec_tst
vcd file -direction Functional.msim.vcd
vcd add -internal Functional_vlg_vec_tst/*
vcd add -internal Functional_vlg_vec_tst/i1/*
add wave /*
run -all
