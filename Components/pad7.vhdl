library ieee;
use ieee.std_logic_1164.all;

entity pad7 is
	port(
		input: in std_logic_vector(8 downto 0);
		output: out std_logic_vector(15 downto 0));
end entity;

architecture pad of pad7 is
begin
	
	output(15 downto 7) <= input;
	for i in 0 to 6 generate
		output(i) <= '0';
	end generate;
	
end architecture;