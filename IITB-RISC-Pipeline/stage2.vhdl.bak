library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_decode is 
	port(
		clk, reset, stall : in std_logic;
		instr, pc_in : in std_logic_vector(15 downto 0);
		opcode : out std_logic_vector(3 downto 0);
		ra, rb, rc : out std_logic_vector(2 downto 0);
		condition : out std_logic_vector(1 downto 0);
		imm6 : out std_logic_vector(15 downto 0);
		imm9 : out std_logic_vector(15 downto 0);
		pc_out : out std_logic_vector(15 downto 0)
	);
end entity;

architecture id_arch of instr_decode is 

	component sign_extend7 is
		port(
			input: in std_logic_vector(8 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component sign_extend10 is
		port(
			input: in std_logic_vector(5 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component pad7 is
		port(
			input: in std_logic_vector(8 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal se7_out, se10_out, p7_out : std_logic_vector(15 downto 0);
	
begin	

	se7 : sign_extend7 port map(input => instr(8 downto 0), output => se7_out);
	se10 : sign_extend10 port map(input => instr(5 downto 0), output => se10_out);
	p7 : pad7 port map(input => instr(8 downto 0), output => p7_out);
	
	
	pc_out <= pc_in
	opcode <= instr(15 downto 12);
	ra <= instr(11 downto 9);
	rb <= instr(8 downto 6);
	rc <= instr(5 downto 3);
	condition <= instr(1 downto 0);
	imm6 <= se10_out;
	imm9 <= p7_out when instr(15 downto 12) = "0011" else se7_out;
	
end architecture;