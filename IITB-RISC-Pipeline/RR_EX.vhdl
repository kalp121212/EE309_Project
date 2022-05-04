library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RR_EX_reg is
	port(
		clk, reset, write_enable : std_logic;
		----
		pc_in : in std_logic_vector(15 downto 0);
		opcode_in : in std_logic_vector(3 downto 0);
		ra_in, rb_in, rc_in : in std_logic_vector(2 downto 0);
		cond_in : in std_logic_vector(1 downto 0);
		imm6_in : in std_logic_vector(15 downto 0);
		imm9_in : in std_logic_vector(15 downto 0);
		----
		pc_out : out std_logic_vector(15 downto 0);
        imm6_out : out std_logic_vector(15 downto 0);
        imm9_out : out std_logic_vector(15 downto 0);
        opcode_out : out std_logic_vector(3 downto 0);
        ra,rb,rb_left_shift : out std_logic_vector(15 downto 0);
        cond_out : out std_logic_vector(1 downto 0);
        rc_out : out std_logic_vector(2 downto 0);
        carry_out : out std_logic
	);
end entity;