library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MA_WB_register is
    port(
        clk, reset, stall : in std_logic;

        alu_out_in : in std_logic_vector(15 downto 0);
        opcode_in : in std_logic_vector(3 downto 0);
        reg_out_in : in std_logic_vector(2 downto 0);
        carry_in,z_in,eq_in : in std_logic;
        next_instr : in std_logic_vector(15 downto 0);
        cond_in : in std_logic_vector(1 downto 0);
        pc_in : in std_logic_vector(15 downto 0)

        opcode_out: out std_logic_vector(15 downto 0);
        pc_out : out std_logic_vector(15 down to 0);
        reg_out : out std_logic_vector(2 downto 0);
        alu_out : out std_logic_vector(15 downto 0);
        Z_out,carry_out : out std_logic;
        cond_out : out std_logic_vector(1 downto 0)
    );
end entity;