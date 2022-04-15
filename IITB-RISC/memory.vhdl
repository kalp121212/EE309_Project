library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
        --clock
        clk : in std_logic;

        --write enable bit
        write_enable : in std_logic;

        --reset bit
        reset : in std_logic;

        --16 bit address
        mem_A : in std_logic_vector(15 downto 0);

        --data input to the memory
        mem_Din : in std_logic_vector(15 downto 0);

        --data output from the memory
        mem_Dout : out std_logic_vector(15 downto 0));
    
end entity;

architecture memory_a of memory is
type memory_array is array( 0 to 127 ) of std_logic_vector(15 downto 0);
signal data : memory_array := (0 => "0011001001011010", 1 => "1111000000000000", others => (others => '0'));

begin
    memory_mod: process(clk)
    begin
		  --if(reset = '1') then data <= (others => X"0000");
        if (clk'event and clk = '0') then  --falling edge edge
            if (write_enable = '1') then
                data(to_integer(unsigned(mem_A(6 downto 0)))) <= mem_Din;
            end if;
        end if;
    end process memory_mod;
            
    mem_Dout <= data(to_integer(unsigned(mem_A(6 downto 0))));

	 
    --Reset_data: process(reset)
    --begin
    --    if( reset='1') then
    --        data <= (others => X"0000");
    --        --Fill required instructions here when run
    --    end if;
    --end process Reset_data;
	 
end architecture memory_a;
