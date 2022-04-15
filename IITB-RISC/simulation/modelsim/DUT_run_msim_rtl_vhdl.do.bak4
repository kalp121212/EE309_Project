transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/state_controller.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/sign_extend10.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/sign_extend7.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/risc.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/register_file.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/register_component.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/pad7.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/memory.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/lshift.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/DUT.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/datapath.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/comp.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/ALU.vhd}

vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
