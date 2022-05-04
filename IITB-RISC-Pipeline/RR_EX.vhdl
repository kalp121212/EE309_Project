library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RR_EX_reg is
	port(
		clk, reset, write_enable : std_logic;
		----
		opcode_in : in std_logic_vector(3 downto 0);
	    rc_in : in std_logic_vector(2 downto 0);
		cond_in : in std_logic_vector(1 downto 0);
		imm6_in : in std_logic_vector(15 downto 0);
		imm9_in : in std_logic_vector(15 downto 0);
		pc_in, ra_val_in, rb_val_in: out std_logic_vector(15 downto 0)
		----
		pc_out : out std_logic_vector(15 downto 0);
        imm6_out : out std_logic_vector(15 downto 0);
        imm9_out : out std_logic_vector(15 downto 0);
        opcode_out : out std_logic_vector(3 downto 0);
        ra,rb : out std_logic_vector(15 downto 0);
        cond_out : out std_logic_vector(1 downto 0);
        rc_out : out std_logic_vector(2 downto 0)
        --carry_out : out std_logic
	);
end entity;

architecture reg of RR_EX_reg is
    signal reg_data1 : std_logic_vector(15 downto 0);
    signal reg_data2 : std_logic_vector(15 downto 0);
    signal reg_data3 : std_logic_vector(15 downto 0);
    signal reg_data4 : std_logic_vector(3 downto 0);
    signal reg_data5 : std_logic_vector(15 downto 0);
    signal reg_data6 : std_logic_vector(15 downto 0);
    signal reg_data7 : std_logic_vector(1 downto 0);
    signal reg_data8 : std_logic_vector(2 downto 0);

begin
    reg_data1 <= pc_in when write_enable = '1';
    reg_data2 <= ra_val_in when write_enable = '1';
    reg_data3 <= rb_val_in when write_enable = '1';
    reg_data4 <= opcode_in when write_enable = '1';
    reg_data5 <= imm9_in when write_enable = '1';
    reg_data6 <= imm6_in when write_enable = '1';
    reg_data7 <= cond_in when write_enable = '1';
    reg_data8 <= rc_in when write_enable = '1';

    write_proc : process(clk,write_enable,pc_in,opcode_in,ra_in,rb_in,rc_in,cond_in,imm6_in,imm9_in,reset,ra_val_in,rb_val_in)
    begin
        if(reset = '1') then 
			pc_out <= (others => '1');
			opcode_out <= (others => '1');
			ra_out <= (others => '1');
			cond_out <= (others => '1');
			imm6_out <= (others => '1');
			imm9_out <= (others => '1');
            ra_val_in <= (others => '1');
            rb_val_in <= (others => '1');
        elsif (clk'event and clk = '0') then  
            pc_out <= reg_data1;
            ra <= reg_data2;
            rb <= reg_data3;
            opcode_out <= reg_data4;
            imm9_out <= reg_data5;
            imm6_out <= reg_data6;
            cond_out <= reg_data7;
            rc_out <= reg_data8;
        end if;
    end process;

end architecture;
