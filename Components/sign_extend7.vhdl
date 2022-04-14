library ieee;
use ieee.std_logic_1164.all;

entity sign_extend7 is
	port(
		input: in std_logic_vector(8 downto 0);
		output: out std_logic_vector(15 downto 0));
end entity;

architecture extend7 of sign_extend7 is
begin
	
	output(8 downto 0) <= input;
	for i in 9 to 15 generate
		output(i) <= input(8);
	end generate;
	
end architecture;