transcript on

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work


vlog -vlog01compat -work work +incdir+F:/Files/HDLfiles/2019/January/FIFO_verification/simulation/modelsim {F:/Files/HDLfiles/2019/January/FIFO_verification/simulation/modelsim/fifo.vo}

vlog -sv -work work +incdir+F:/Files/HDLfiles/2019/January/FIFO_verification/simulation/modelsim {F:/Files/HDLfiles/2019/January/FIFO_verification/simulation/modelsim/tb_fifo_top.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc" tb_fifo_top

add wave sim:/tb_fifo_top/intf/*
view structure
view signals
run -all
