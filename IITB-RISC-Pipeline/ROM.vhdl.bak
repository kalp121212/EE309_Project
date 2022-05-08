library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity code_memory is
    port(
        --16 bit address
        mem_A : in std_logic_vector(15 downto 0);
        --data output from the memory
        mem_Dout : out std_logic_vector(15 downto 0)
	);  
end entity;

architecture memory_a of code_memory is
type memory_array is array( 0 to 65535 ) of std_logic_vector(15 downto 0);
signal data : memory_array := (0 => "0000001000000000", 1 => "0010000111001001", others => (others => '1')); --Load with Program

begin
            
    mem_Dout <= data(to_integer(unsigned(mem_A)));

end architecture memory_a;