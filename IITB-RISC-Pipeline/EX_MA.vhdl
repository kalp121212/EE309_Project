library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EX_MA_register is
    port(
        clk, reset, write_enable : std_logic;

        opcode_in : out std_logic_vector(3 downto 0);
        rc_in : in std_logic_vector(2 downto 0);
        cond_in : in std_logic_vector(1 downto 0);
        alu_out_in : in std_logic_vector(15 downto 0);
        Z_in,carry_in,eq_in : in std_logic;
        ra_in : in std_logic_vector(15 downto 0);
		pc_in : in std_logic_vector(15 downto 0);

        pc_out : out std_logic_vector(15 downto 0);
        alu_out : out std_logic_vector(15 downto 0);
        opcode_in : out std_logic_vector(3 downto 0);
        carry_out, z_out, eq_out : out std_logic;
        reg_out : out std_logic_vector(2 downto 0);
        ra_out : out std_logic_vector(15 downto 0);
        cond_out : out std_logic_vector(1 downto 0)
    );
end entity;