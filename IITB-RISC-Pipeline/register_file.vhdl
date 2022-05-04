library ieee;
use ieee.std_logic_1164.all;

entity register_file is 
    port(
        --to store the register number for each address
        A1 : in std_logic_vector(2 downto 0);
        A2 : in std_logic_vector(2 downto 0);
        A3 : in std_logic_vector(2 downto 0);

        -- input data
        D3 : in std_logic_vector(15 downto 0);
	PC : in std_logic_vector(15 downto 0);

        write_enable : in std_logic;
	write_pc : in std_logic;
        read_enable : in std_logic;

        reset : in std_logic;

        clk : in std_logic;

        --output data
        D1 : out std_logic_vector(15 downto 0);
        D2 : out std_logic_vector(15 downto 0);

        R7_PC : out std_logic_vector(15 downto 0)

    );
end entity;

architecture rf of register_file is    
    signal R0 : std_logic_vector(15 downto 0);
    signal R1 : std_logic_vector(15 downto 0);
    signal R2 : std_logic_vector(15 downto 0);
    signal R3 : std_logic_vector(15 downto 0);
    signal R4 : std_logic_vector(15 downto 0);
    signal R5 : std_logic_vector(15 downto 0);
    signal R6 : std_logic_vector(15 downto 0);
    signal R7 : std_logic_vector(15 downto 0);
	 signal D1_temp : std_logic_vector(15 downto 0);
    signal D2_temp : std_logic_vector(15 downto 0);
begin
    --writing to register when write_enable is set
    write_proc: process(A3,write_enable,write_pc,clk,reset)
    begin
	     if(reset = '1') then 
            R0 <= "0000000000000000";
            R1 <= "0000000000000000";
            R2 <= "0000000000000000";
            R3 <= "0000000000000000";
            R4 <= "0000000000000000";
            R5 <= "0000000000000000";
            R6 <= "0000000000000000";
            R7 <= "0000000000000000";
        elsif (clk'event and clk = '0') then  --writing at negative clock edge
            if(write_enable = '1') then
                if(A3 = "000") then
                    R0 <= D3;
                end if;
                if(A3 = "001") then
                    R1 <= D3;
                end if;
                if(A3 = "010") then
                    R2 <= D3;
                end if;
                if(A3 = "011") then
                    R3 <= D3;
                end if;
                if(A3 = "100") then
                    R4 <= D3;
                end if;
                if(A3 = "101") then
                    R5 <= D3;
                end if;
                if(A3 = "110") then
                    R6 <= D3;
                end if;
                if(A3 = "111") then
                    R7 <= D3;
                end if;
            end if;
	    if (write_pc = '1') then
            	R7 <= PC;
	    end if;
        end if;
    end process write_proc;
	 
	 D1 <= D1_temp when read_enable = '1';
	 D2 <= D2_temp when read_enable = '1';

    --reading from the registers
    read_proc: process(A1,A2,read_enable)


    begin
        if(read_enable = '1') then
            if(A1 = "000") then
                D1_temp <= R0;
            end if;
            if(A1 = "001") then
                D1_temp <= R1;
            end if;
            if(A1 = "010") then
                D1_temp <= R2;
            end if;
            if(A1 = "011") then
                D1_temp <= R3;
            end if;
            if(A1 = "100") then
                D1_temp <= R4;
            end if;
            if(A1 = "101") then
                D1_temp <= R5;
            end if;
            if(A1 = "110") then
                D1_temp <= R6;
            end if;
            if(A1 = "111") then
                D1_temp <= R7;
            end if;
            --Address 2
            if(A2 = "000") then
                D2_temp <= R0;
            end if;
            if(A2 = "001") then
                D2_temp <= R1;
            end if;
            if(A2 = "010") then
                D2_temp <= R2;
            end if;
            if(A2 = "011") then
                D2_temp <= R3;
            end if;
            if(A2 = "100") then
                D2_temp <= R4;
            end if;
            if(A2 = "101") then
                D2_temp <= R5;
            end if;
            if(A2 = "110") then
                D2_temp <= R6;
            end if;
            if(A2 = "111") then
                D2_temp <= R7;
            end if;    
        end if;
        --D1 <= D1_temp;
        --D2 <= D2_temp;
    end process read_proc;

    
R7_PC <= R7;
end rf;
