library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_access is 
    port(
        clk, reset, stall : in std_logic;
        pc_in : in std_logic_vector(15 downto 0);
        alu_out_in : in std_logic_vector(15 downto 0);
        opcode_in : in std_logic_vector(3 downto 0);
        carry_in, z_in, eq_in : in std_logic;
        reg_in : in std_logic_vector(2 downto 0);
        ra_in : in std_logic_vector(15 downto 0);
        cond_in : in std_logic_vector(1 downto 0);

        alu_out : out std_logic_vector(15 downto 0);
        opcode_out : out std_logic_vector(3 downto 0);
        reg_out : out std_logic_vector(2 downto 0);
        carry_out,z_out: out std_logic;
       -- next_instr : out std_logic_vector(15 downto 0);
        cond_out : out std_logic_vector(1 downto 0);
        pc_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture ma_arch of memory_access is

    component code_memory is 
		port(
			mem_A : in std_logic_vector(15 downto 0);
			mem_Dout : out std_logic_vector(15 downto 0)
		);
	end component;

    component data_memory is 
		port(
            clk : in std_logic;
            write_enable : in std_logic;
            reset : in std_logic;
			mem_A : in std_logic_vector(15 downto 0);
            mem_Din : in std_logic_vector(15 downto 0);

			mem_Dout : out std_logic_vector(15 downto 0)
		);
	end component;

    signal mem_code,mem_data,d_out ,data,next_instr: std_logic_vector(15 downto 0);

begin
    opcode_out <= opcode_in;
    pc_out <= pc_in;
    carry_out <= carry_in;
    z_out <= z_in;
    reg_out <= reg_in;
    alu_out <= alu_out_in;
    cond_out <= cond_in;

    memory_access: code_memory port map(mem_A => mem_code, mem_Dout => next_instr);
    data_memory_access : data_memory port map(clk => clk, write_enable =>enable,reset +> reset, mem_A => mem_data,mem_Din => data,mem_Dout => d_out);

    branches: process(clk,reset,stall)

    begin
        if(clk'event and clk = '0' and stall = '0') then 
            if(opcode_in = "1000") then
                if(eq_in = '1') then 
                    mem_code <= alu_out_in;
                else
                    mem_code <= pc_in;
                end if;
            
            elsif(opcode_in = "1001" or opcode_in = "1010" or opcode_in = "1011") then
                mem_code <= alu_out_in;
            end if;
        end if;
    end process;

    store_data: process(clk,reset,stall)

    begin 
        if(clk'event and clk = '0' and stall = '0') then
            if(opcode_in = "0101")
                mem_data <= alu_out_in;
                data <= ra_in;
                enable <= '1';
            else
                enable <= '0';
            end if;
        end if;
    end process;

end architecture;