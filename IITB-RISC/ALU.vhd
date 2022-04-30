library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    port (
        A: in std_logic_vector(15 downto 0);
        B: in std_logic_vector(15 downto 0);
		  Cin: in std_logic;
        sel: in std_logic;
		  EN: in std_logic;
        op: out std_logic_vector(15 downto 0);
		  Cout: out std_logic;
		  Z: out std_logic
    ) ;
end ALU;

architecture a1 of ALU is
	--signal C_init: std_logic:= '0';
	signal outSum: std_logic_vector(15 downto 0):= "0000000000000000";
	signal outNAND: std_logic_vector(15 downto 0):= "0000000000000000";
begin

	op <= outSUM when sel ='0' else outNAND when sel='1';

	alu : process( A, B, sel, Cin, EN)
	variable C_init : std_logic := '0';
	begin
		C_init := Cin;
		if (sel = '0') then
			Addition: for i in 0 to 15 loop
				outSum(i)<= A(i) XOR B(i) XOR C_init;
				C_init := ( A(i) AND B(i) ) OR (C_init AND (A(i) XOR B(i)));
			end loop;
		 	if(EN = '1') then
				Cout <= C_init;
			end if;
		 	if (outSum = "0000000000000000" and C_init = '0') then
				Z <= '1';
		 	else 
				Z <= '0';
			end if;
		elsif (sel = '1') then
			outNAND <= A nand B;
			if (outNAND = "0000000000000000") then
				Z <= '1';
		 	else 
				Z <= '0';
			end if;
		end if;
	end process ;
end a1 ;