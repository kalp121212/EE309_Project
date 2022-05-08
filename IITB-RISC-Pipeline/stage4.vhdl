library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity execute is
	port(
		clk, reset, stall : in std_logic;
        pc_in : in std_logic_vector(15 downto 0);
        imm6_in : in std_logic_vector(15 downto 0);
        imm9_in : in std_logic_vector(15 downto 0);
        opcode_in : in std_logic_vector(3 downto 0);
        ra,rb : in std_logic_vector(15 downto 0);
        cond_in : in std_logic_vector(1 downto 0);
        rc_in : in std_logic_vector(2 downto 0);
   --     carry_in : in std_logic;

		reg_change : out std_logic;
        opcode_out : out std_logic_vector(3 downto 0);
        rc_out : out std_logic_vector(2 downto 0);
        cond_out : out std_logic_vector(1 downto 0);
        alu_out : out std_logic_vector(15 downto 0);
        Z_out,carry_out,eq_out : out std_logic;
        ra_out : out std_logic_vector(15 downto 0);
		pc_out : out std_logic_vector(15 downto 0)
	);
end entity;

architecture ex_arch of execute is

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

    component comparator is
        port(
		input1: in std_logic_vector(15 downto 0);
		input2: in std_logic_vector(15 downto 0);

		status: out std_logic
        );
    end component;

    signal alu_in1,alu_in2: std_logic_vector(15 downto 0) := (others => '0');
    signal alu_select,enable,eq: std_logic;

begin
    pc_out <= pc_in;
    opcode_out <= opcode_in;
    cond_out <= cond_in;
    ra_out <= ra;
	rc_out <= rc_in;
	reg_change <= '1' when opcode_in(3 downto 2) /= "10" else '0';    --Instruction alters register value 
	
    alu_use : alu port map(A => alu_in1, B => alu_in2, Cin => '0', sel => alu_select, EN => enable, op => alu_out, Cout => carry_out, Z => Z_out);
    comp_use : comparator port map(input1 => alu_in1, input2 => alu_in2, status => eq_out);

    alu_process: process(opcode_in,pc_in,imm6_in,imm9_in,ra,rb,cond_in,rc_in)
    begin
            if(opcode_in = "0001") then
                alu_select <= '0';
                alu_in1 <= ra;
                enable <= '1';
                alu_in2 <= rb;
            elsif(opcode_in = "0000") then
                alu_select <= '0';
                alu_in1 <= ra;
                alu_in2 <= imm6_in;
                enable <= '1';
            elsif(opcode_in = "0010") then
                alu_select <= '1';
                alu_in1 <= ra;
                alu_in2 <= rb;
                enable <= '1';
            elsif (opcode_in = "0011") then
                alu_select <= '0';
                alu_in1 <= imm9_in;
                alu_in2 <= "0000000000000000";
                enable <= '0';
            elsif (opcode_in = "0111" or opcode_in = "0101") then
                alu_select <= '0';
                alu_in1 <= imm6_in;
                alu_in2 <= rb;
                enable <= '0';
            elsif(opcode_in = "1000") then
                alu_select <= '0';
                alu_in1 <= pc_in;
                alu_in2 <= imm6_in;
                enable <= '0';
            elsif(opcode_in = "1001") then
                alu_select <= '0';
                alu_in1 <= pc_in;
                alu_in2 <= imm9_in;
                enable <= '0';
            elsif(opcode_in = "1010") then
                alu_select <= '0';
                alu_in1 <= rb;
                alu_in2 <= "0000000000000000";
                enable <= '0';
            elsif(opcode_in = "1011") then
                alu_select <= '0';
                alu_in1 <= ra;
                alu_in2 <= imm9_in;
                enable <= '0';
            end if;

    end process;

end architecture;