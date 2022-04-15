library ieee;
use ieee.std_logic_1164.all;
entity DUT is
   port(input_vector: in std_logic_vector(1 downto 0);
       	output_vector: out std_logic_vector(0 downto 0));
end entity;

architecture DutWrap of DUT is
	component iitb_risc is
		port(reset_main, clock_main : in std_logic);
	end component;
begin
   add_instance: iitb_risc
		port map(
			reset_main => input_vector(1),
			clock_main => input_vector(0)
		);
end DutWrap;