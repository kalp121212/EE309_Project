library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID_reg is
	port(
		clk, reset, write_enable : in std_logic;
		instr_in, pc_in : in std_logic_vector(15 downto 0);
		instr_out, pc_out : out std_logic_vector(15 downto 0)
	);
end entity;

architecture reg of IF_ID_reg is
	signal reg_data1, reg_data2 : std_logic_vector(15 downto 0);
begin	
	
	reg_data1 <= instr_in when write_enable = '1';
	reg_data2 <= pc_in when write_enable = '1';
	
	write_proc: process(clk,write_enable,instr_in,pc_in,reset)
    begin
		if(reset = '1') then 
			instr_out <= (others => '1');
			pc_out <= (others => '1');
        elsif (clk'event and clk = '0') then  
            instr_out <= reg_data1;
			pc_out <= reg_data2;
        end if;
    end process write_proc;
	
end architecture;