library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity write_back is 
    port(
        clk, reset, stall : in std_logic;
        opcode_in: in std_logic_vector(3 downto 0);
        pc_in : in std_logic_vector(15 downto 0);
        reg_in : in std_logic_vector(2 downto 0);
        alu_out : in std_logic_vector(15 downto 0);
        Z_in,carry_in : in std_logic;
        cond_in : in std_logic_vector(1 downto 0);
        reg_out : out std_logic_vector(2 downto 0);
        reg_data : out std_logic_vector(15 downto 0);
        reg_write : out std_logic;
        pc_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture wb_arch of write_back is
      
    signal reg_d : std_logic_vector(15 downto 0);
    signal write_enable : std_logic;

    begin
    reg_out <= reg_in;
    pc_out <= pc_in ;
    reg_data <= reg_d;
    reg_write <= write_enable;

    store_register : process(opcode_in,cond_in,alu_out,carry_in,z_in,pc_in)

    begin
            if((opcode_in = "0001" and (cond_in="00" or cond_in ="11")) or (opcode_in="0010" and cond_in="00") or opcode_in = "0011" or opcode_in = "0111" or opcode_in = "0000") then
                reg_d <= alu_out;
                write_enable <= '1'; 
            elsif ((opcode_in = "0001" and cond_in="10") or (opcode_in = "0010" and cond_in="10")) then
                reg_d <= alu_out;
                write_enable <= carry_in;
            elsif ((opcode_in = "0001" and cond_in="01") or (opcode_in = "0010" and cond_in="01")) then
                reg_d <= alu_out;
                write_enable <= Z_in;
            elsif(opcode_in = "1001" or opcode_in = "1010") then
                reg_d <= pc_in;
                write_enable <= '1';
            else
                write_enable <= '0';
            end if;
    end process;

end architecture;
