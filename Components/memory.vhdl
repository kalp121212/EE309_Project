library ieee;
use ieee.std_logic_1164.all;

entity memory is
    port(
        --clock
        clk :in std_logic_1164;

        --write enable bit
        write_enable : in std_logic;

        --reset bit
        reset : in std_logic;

        --16 bit address
        addr : in std_logic_vector(15 downto 0);

        --data input to the memory
        Din : in std_logic_vector(15 downto 0);

        --data output from the memory
        Dout : out std_logic_vector(15 downto 0));
    
end entity;

architecture memory_a of memory is
type memory_array is array( 0 to 127 ) of std_logic_vector(15 downto 0);
signal mem : memory_array := (others => X"0000");

begin
    memory_mod: process(clk, write_enable ,Din ,addr , mem)
    begin
        if (clk'event and clk = '1') then  --rising edge
            if (write_enable = '1') then
                mem(to_integer(unsigned(addr))) <= Din;
            end if;
        end if;
            Dout <= mem(to_integer(unsigned(addr)));
    end process memory_mod;

    Reset: process(reset)
    begin
        if( reset='1') then
           mem <= (others => X"0000");
        end if;
    end process Reset;
end architecture memory_a;
