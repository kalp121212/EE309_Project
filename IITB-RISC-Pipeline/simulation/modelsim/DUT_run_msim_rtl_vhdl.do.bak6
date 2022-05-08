transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/sign_extend10.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/forwarding_unit.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/ALU.vhd}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage6.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage5.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage4.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage3.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage2.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/stage1.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/sign_extend7.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/RR_EX.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/ROM.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/register_file.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/RAM.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/pipeline.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/pad7.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/MA_WB.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/lshift.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/IF_ID.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/ID_RR.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/EX_MA.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/DUT.vhdl}
vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/comp.vhdl}

vcom -93 -work work {C:/Users/Aayush Rajesh/Desktop/IIT-B/Semester 4/EE309/IITB-RISC-Pipeline/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
