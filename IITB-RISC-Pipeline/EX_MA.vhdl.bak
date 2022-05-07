library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EX_MA_reg is
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
        opcode_out : out std_logic_vector(3 downto 0);
        carry_out, z_out, eq_out : out std_logic;
        reg_out : out std_logic_vector(2 downto 0);
        ra_out : out std_logic_vector(15 downto 0);
        cond_out : out std_logic_vector(1 downto 0)
    );
end entity;

architecture reg of EX_MA_reg is
    signal reg_data1 : std_logic_vector(15 downto 0);
    signal reg_data2 : std_logic_vector(15 downto 0);
    signal reg_data3 : std_logic_vector(15 downto 0);
    signal reg_data4 : std_logic_vector(3 downto 0);
    signal reg_data5 : std_logic_vector(1 downto 0);
    signal reg_data6 : std_logic_vector(2 downto 0);
    signal reg_data7 : std_logic;
    signal reg_data8 : std_logic;
    signal reg_data9 : std_logic;

begin
    reg_data1 <= pc_in when write_enable = '1';
    reg_data2 <= ra_in when write_enable = '1';
    reg_data3 <= alu_out_in when write_enable = '1';
    reg_data4 <= opcode_in when write_enable = '1';
    reg_data5 <= cond_in when write_enable = '1';
    reg_data6 <= rc_in when write_enable = '1';
    reg_data7 <= carry_in when write_enable = '1';
    reg_data8 <= z_in when write_enable = '1';
    reg_data9 <= eq_in when write_enable = '1';

    write_proc : process(clk,write_enable,pc_in,opcode_in,alu_out_in,rc_in,cond_in,reset,ra_in,carry_in,z_in,eq_in)
    begin
        if(reset = '1') then 
			pc_out <= (others => '1');
			opcode_out <= (others => '1');
			ra_out <= (others => '1');
			cond_out <= (others => '1');
            ra_val_in <= (others => '1');
            rb_val_in <= (others => '1');
            carry_in <= '1';
            z_in <= '1';
            eq_in <= '1';
        elsif (clk'event and clk = '0') then  
            pc_out <= reg_data1;
            ra <= reg_data2;
            rb <= reg_data3;
            opcode_out <= reg_data4;
            cond_out <= reg_data5;
            reg_out <= reg_data6;
            carry_out <= reg_data7;
            z_out <= reg_data8;
            eq_out <= reg_data9;
        end if;
    end process;

end architecture;
