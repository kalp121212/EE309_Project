library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_read is
	port(
		clk, reset, stall : in std_logic;
		opcode_in : in std_logic_vector(3 downto 0);
		ra_in, rb_in, rc_in : in std_logic_vector(2 downto 0);
		cond_in : in std_logic_vector(1 downto 0);
		imm6_in : in std_logic_vector(15 downto 0);
		imm9_in : in std_logic_vector(15 downto 0);
		pc_in, ra_val_in, rb_val_in : in std_logic_vector(15 downto 0);

		opcode_out : out std_logic_vector(3 downto 0);
		rc_out : out std_logic_vector(2 downto 0);
		cond_out : out std_logic_vector(1 downto 0);
		imm6_out : out std_logic_vector(15 downto 0);
		imm9_out : out std_logic_vector(15 downto 0);
		pc_out, ra_val_out, rb_val_out: out std_logic_vector(15 downto 0)
	);
end entity;

architecture rr_arch is

	component left_shift is
		port(
			input: in std_logic_vector(15 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal rb_lshift : std_logic_vector(15 downto 0);

begin

	lshift : left_shift port map(input => rb_val_in, output => rb_lshift);
	
	opcode_out <= opcode_in;
	rc_out <= rc_in when opcode_in = "0001" or opcode_in = "0010" else
				rb_in when opcode_in = "0000" else ra_in ;
	cond_out <= cond_in;
	imm6_out <= imm6_in;
	imm9_out <= imm9_in;
	pc_out <= pc_in;
	ra_val_out <= ra_val_in;
	rb_val_out <= rb_lshift when cond_in = "11" else rb_val_in;
	
end architecture;