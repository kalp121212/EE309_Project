library ieee;
use ieee.std_logic_1164.all;

entity register_component is 
    port(
        -- input data
        r_in : in std_logic_vector(15 downto 0);

        write_enable : in std_logic;

        reset : in std_logic;

        clk : in std_logic;

        --output data
        r_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rc of register_component is
	signal reg_data : std_logic_vector(15 downto 0);
begin

	 reg_data <= r_in when write_enable = '1';

    write_proc: process(clk,write_enable,r_in, reset)
    begin
		  if(reset = '1') then r_out <= "0000000000000000";
        elsif (clk'event and clk = '0') then  --writing at negative clock edge
            r_out <= reg_data;
        end if;
    end process write_proc;

end rc;