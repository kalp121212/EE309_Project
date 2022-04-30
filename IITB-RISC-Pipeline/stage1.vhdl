library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_fetch is
	port(
		clk, reset, stall : in std_logic;
		instr, pc_out : out std_logic_vector(15 downto 0)
	);
end entity;

architecture if_arch of instr_fetch is
	component code_memory is 
		port(
			mem_A : in std_logic_vector(15 downto 0);
			mem_Dout : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component alu is 
		port(
			A: in std_logic_vector(15 downto 0);
			B: in std_logic_vector(15 downto 0);
		    Cin: in std_logic;
			sel: in std_logic;
		    EN: in std_logic;
			op: out std_logic_vector(15 downto 0);
		    Cout: out std_logic;
		    Z: out std_logic
		);
	end component;
	
	signal pc_val, pc : std_logic_vector(15 downto 0);
	signal pc_carry, pc_z : std_logic;
begin
	cmem : code_memory port map(mem_A => pc, mem_Dout => instr);
	alu_pc : alu port map(A => pc, B => "0000000000000001", Cin => '0', sel => '0', EN => '0', op => pc_val, Cout => pc_carry, Z => pc_z);
	pc_out <= pc;
	
	process(clk, reset, stall)
	begin	
		if(reset = '1') then	
			pc <= "0000000000000000";
		elsif(clk'event and clk = '0' and stall = '0') then 
			if(instr(15 downto 14) /= "10") then 
				pc <= pc_val;
			end if; -- look for branches
		end if;
	end process;
end architecture;