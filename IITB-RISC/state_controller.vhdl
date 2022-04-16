------ IITB-RISC
------ TEAM MEMBERS:
------ AAYUSH RAJESH  (200070001)
------ KALP VYAS      (200070030)
------ PULKIT PALIWAL (20D100021)
------ SIDHANT BOSE   (200020140)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is 
	port(
		C, Z, eq, clk, rst : in std_logic;
		opcode : in std_logic_vector(3 downto 0);
		condition : in std_logic_vector(1 downto 0);
		
		stateID : out std_logic_vector(4 downto 0)
	);
end entity;

architecture fsm of controller is

	type state is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31);
	signal scurr, snext : state := s1; 
	
begin

	clock : process(clk, rst)
	begin	
		if(clk='0' and clk' event) then
			if(rst='1') then
				scurr <= s1; 
			else 
				scurr <= snext;
			end if;
		end if;
	end process;
	
	transition : process(opcode, scurr, C, Z, eq, condition)
	begin
		if(rst = '0') then
		case scurr is
			when s0 =>
				stateID <= "00000";
				snext <= s0;
			when s1 =>  
				stateID <= "00001";
				snext <= s2;
			when s2 => 
				stateID <= "00010";
				if(opcode = "0001" or opcode = "0010") then
					if(condition = "00" or condition = "11") then snext <= s3;
					elsif(condition = "10" and C = '1') then snext <= s3;
					elsif(condition = "01" and Z = '1') then snext <= s3;
					else snext <= s5;
					end if;
				elsif(opcode = "0011") then snext <= s8;
				elsif(opcode = "1001") then snext <= s13;
				elsif(opcode = "1010") then snext <= s14;
				elsif(opcode = "1111") then snext <= s0;
				elsif opcode = "1000" then 
					if(eq = '1') then snext <= s12;
					else snext <= s5;
					end if; 
				elsif(opcode = "1011") then snext <= s15;
				elsif(opcode = "1100") then snext <= s16;
				elsif(opcode = "1101") then snext <= s24;
				else snext <= s6;
				end if;
			when s3 =>
				stateID <= "00011";
				snext <= s4;
			when s4 =>
				stateID <= "00100";
				snext <= s5;
			when s5 =>
				stateID <= "00101";
				snext <= s1;
			when s6 => 
				stateID <= "00110";
				if(opcode = "0000") then
					snext <= s7;
				elsif(opcode = "0101") then
					snext <= s9;
				else snext <= s10;
				end if;
			when s7 =>
				stateID <= "00111";
				snext <= s5;
			when s8 =>
				stateID <= "01000";
				snext <= s5;
			when s9 =>
				stateID <= "01001";
				snext <= s5;
			when s10 =>
				stateID <= "01010";
				snext <= s11;
			when s11 =>
				stateID <= "01011";
				snext <= s5;
			when s12 =>
				stateID <= "01100";
				snext <= s5;
			when s13 =>
				stateID <= "01101";
				snext <= s5;
			when s14 => 
				stateID <= "01110";
				snext <= s5;
			when s15 =>
				stateID <= "01111";
				snext <= s5;
			when s16 =>
				stateID <= "10000";
				snext <= s17;
			when s17 =>
				stateID <= "10001";
				snext <= s18;
			when s18 =>
				stateID <= "10010";
				snext <= s19;
			when s19 =>
				stateID <= "10011";
				snext <= s20;
			when s20 =>
				stateID <= "10100";
				snext <= s21;
			when s21 =>
				stateID <= "10101";
				snext <= s22;
			when s22 =>
				stateID <= "10110";
				snext <= s23;
			when s23 =>
				stateID <= "10111";
				snext <= s5;
			when s24 =>
				stateID <= "11000";
				snext <= s25;
			when s25 =>
				stateID <= "11001";
				snext <= s26;
			when s26 =>
				stateID <= "11010";
				snext <= s27;
			when s27 =>
				stateID <= "11011";
				snext <= s28;
			when s28 =>
				stateID <= "11100";
				snext <= s29;
			when s29 =>
				stateID <= "11101";
				snext <= s30;
			when s30 =>
				stateID <= "11110";
				snext <= s31;
			when s31 =>
				stateID <= "11111";
				snext <= s5;
		end case;
		end if;
	end process;
end architecture;
