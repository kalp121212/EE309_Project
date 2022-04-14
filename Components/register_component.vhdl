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

begin
    write: process(clk,write_enable,r_in)
    begin
        if (clk'event and clk = '0') then  --writing at negative clock edge
            r_out <= r_in;
        end if;
    end process write;

    Reset: process(reset)
    begin
        if(reset='1') then
            r_out <= "0000000000000000";
        end if;
    end process Reset;

end rc;