library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    generic(
        operand_width : integer:=16;
        sel_line : integer:=1
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
		Cin: in std_logic;
        sel: in std_logic_vector(sel_line-1 downto 0);
		EN: in std_logic;
        op: out std_logic_vector(operand_width-1 downto 0);
		  Cout: out std_logic;
		  Z: out std_logic
    ) ;
end ALU;

architecture a1 of ALU is
	signal C_init: std_logic:= '0';
	signal outSum: std_logic_vector(15 downto 0):= "0000000000000000";
	signal outNAND: std_logic_vector(15 downto 0):= "0000000000000000";
	begin
	alu : process( A, B, sel, Cin, EN)
	begin
		C_init <= Cin;
		if sel="0" then
			Addition: for i in 0 to 15 loop
				outSum(i)<= A(i) XOR B(i) XOR C_init;
				C_init<= ( A(i) AND B(i) ) OR (C_init AND (A(i) XOR B(i)));
			end loop;
		 	if(EN = '1') then
				Cout <= C_init;
			end if;
		 	op<= outSum;
		 	if (outSum = "0000000000000000" and C_init = '0') then
				Z <= '1';
		 	else 
				Z <= '0';
			end if;
		else
			NandOp: for i in 0 to 15 loop
				outNAND(i) <= A(i) NAND B(i); 
			end loop;
			op <= outNAND;
			if (outNAND = "0000000000000000") then
				Z <= '1';
		 	else 
				Z <= '0';
			end if;
		end if;
	end process ;
end a1 ;
