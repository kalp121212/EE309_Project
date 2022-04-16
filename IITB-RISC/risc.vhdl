------ IITB-RISC
------ TEAM MEMBERS:
------ AAYUSH RAJESH  (200070001)
------ KALP VYAS      (200070030)
------ PULKIT PALIWAL (20D100021)
------ SIDHANT BOSE   (200020140)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iitb_risc is
	port(
		clk_main, rst_main : in std_logic;
		output_dummy : out std_logic
	);
end entity;

architecture final of iitb_risc is
	component controller is 
		port(
			C, Z, eq, clk, rst : in std_logic;
			opcode : in std_logic_vector(3 downto 0);
			condition : in std_logic_vector(1 downto 0);
			
			stateID : out std_logic_vector(4 downto 0)
		);
	end component;
	
	component datapath is
		port(
			state : in std_logic_vector(4 downto 0);
			clk, rst : in std_logic;
			
			opcode : out std_logic_vector(3 downto 0);
			condition : out std_logic_vector(1 downto 0);
			C, Z, eq : out std_logic
		);
	end component;
	
	signal opcode_signal : std_logic_vector(3 downto 0);
	signal cond_signal : std_logic_vector(1 downto 0);
	signal state_signal : std_logic_vector(4 downto 0);
	signal C_sig, Z_sig, eq_sig : std_logic;

begin
	
	cotroller_main : controller port map(C => C_sig, Z => Z_sig, eq => eq_sig, clk => clk_main, rst => rst_main, opcode => opcode_signal, condition => cond_signal, stateID => state_signal);
	datapath_main : datapath port map(state => state_signal, clk => clk_main, rst => rst_main, opcode => opcode_signal, condition => cond_signal, C => C_sig, Z => Z_sig, eq => eq_sig);
	output_dummy <= '1';
	
end architecture;
	
	