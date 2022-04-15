library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity datapath is
	port(
		state : in std_logic_vector(4 downto 0);
		clk, rst : in std_logic;
		
		opcode : out std_logic_vector(3 downto 0);
		condition : out std_logic_vector(1 downto 0);
		C, Z, eq : out std_logic
	);
end entity;

architecture arch of datapath is

	component ALU is
		port(
			A, B : in std_logic_vector(15 downto 0);
			Cin, sel, EN : in std_logic;
			op : out std_logic_vector(15 downto 0);
			Cout, Z : out std_logic;
		);
	end component;
	
	component comparator is
		port(
			input1, input2 : in std_logic_vector(15 downto 0);
			status : out std_logic
		);
	end component;
	
	component left_shift is
		port(
			input: in std_logic_vector(15 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component memory is
		port(
			clk, write_enable, reset : in std_logic;
			mem_A, mem_Din : in std_logic_vector(15 downto 0);
			mem_Dout : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component pad7 is
		port(
			input: in std_logic_vector(8 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component register_component is 
		port(
			r_in : in std_logic_vector(15 downto 0);
			write_enable, reset, clk : in std_logic;
			r_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component register_file is 
		port(
			A1, A2, A3 : in std_logic_vector(2 downto 0);
			D3 : in std_logic_vector(15 downto 0);
			write_enable, read_enable, reset, clk : in std_logic;
			D1, D2, R7_PC : out std_logic_vector(15 downto 0);
		);
	end component;
	
	component sign_extend10 is
		port(
			input: in std_logic_vector(5 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component sign_extend7 is
		port(
			input: in std_logic_vector(8 downto 0);
			output: out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal aluA,aluB,aluO,lso,memAddr,memDi,memDo,pado,t1in,t1out,t2out,t3in,t3out,tsumout,irout,rd1,rd2,rd3,r7out,rfread,se10,se7 : std_logic_vector(15 downto 0) : (others => '0');  --16 bit
	signal aluCi, aluCo, aluZ, aluOp, comp_eq : std_logic;     --1 bit
	signal ra1, ra3 : std_logic_vector(2 downto 0) : (others => '0');
	signal wr_en : std_logic_vector(7 downto 0) : (others => '0');
	
begin
	--Registers
	t1 : register_component port map (r_in => t1in, write_enable => wr_en(5), reset => rst, clk => clk, r_out => t1out);
	t2 : register_component port map (r_in => rd2, write_enable => wr_en(4), reset => rst, clk => clk, r_out => t2out);
	t3 : register_component port map (r_in => t3in, write_enable => wr_en(3), reset => rst, clk => clk, r_out => t3out);
	tsum : register_component port map (r_in => aluO, write_enable => wr_en(2), reset => rst, clk => clk, r_out => tsumout);
	ir : register_component port map (r_in => memDo, write_enable => wr_en(1), reset => rst, clk => clk, r_out => irout);
	--ALU
	alu_instance : alu port map(A => aluA, B => aluB, Cin => aluCi, sel => aluOp, EN => wr_en(0), op => aluO, Cout => aluCo, Z => aluZ);
	--Comparator
	comp : comparator port map(input1 => rd1, input2 => rd2, status => comp_eq);
	--Shifter
	lshift : left_shift port map(input => t2out, output => lso);
	--Memory
	mem : memory port map(clk => clk, write_enable => wr_en(6), reset => rst, mem_A => memAddr, mem_Din => memDi, mem_Dout => memDo);
	--Padder
	pad : pad7 port map(input => irout(8 downto 0), output => pado);
	--Register File
	rf : register_file port map(A1 => ra1, A2 => irout(8 downto 6), A3 => ra3, D3 => rd3, write_enable => wr_en(7), read_enable => rfread, reset => rst, clk => clk, D1 => rd1, D2 => rd2, r7_pc => r7out);
	--Sign Extenders
	sign_extend_10 : sign_extend10 port map(input => irout(5 downto 0), output => se10);
	sign_extend_7 : sign_extend7 port map(input => irout(8 downto 0), output => se7);
	
	
	process(state):
	begin	
		case state is 
			when "00001" => 
				memAddr <= r7out;
				aluA <= r7out;
				aluB <= "0000000000000001";
				t3in <= aluO;
				wr_en <= "00001010";
			when "00010" =>
				ra1 <= irout(11 downto 9);
				t1in <= rd1;
				wr_en <= "00110000"
			when "00011" =>
				aluA <= t1out;
				aluCi <= '0' when aluCo = '0' else '1';
				if (irout(1 downto 0) = "11") then aluB <= lso;
				else aluB <= t2out;
				end if;
				wr_en <= "00000101";
				aluOp <= irout(13);
			when "00100" =>
				ra3 <= irout(5 downto 3);
				rd3 <= tsumout;
				wr_en <= "10000000"; 
			when "00101" =>
				ra3 <= "111";
				rd3 <= t3out;
				wr_en <= "10000000"; 
			when "00110" =>
				if(irout(15 downto 12) = "0000") then aluA <= t1;
				else aluA <= t2;
				aluB <= se10;
				aluOp <= '0';
				wr_en <= "00000101";
			when "00111" =>
				ra3 <= irout(8 downto 6);
				rd3 <= tsumout;
				wr_en <= "10000000";
			when "01000" =>
				rd3 <= pado;
				ra3 <= irout(11 downto 9);
				wr_en <= "10000000";
			when "01001" =>
				memAddr <= tsumout;
				memDi <= t1out;
				wr_en <= "01000000";
			when "01010" =>
				memAddr <= tsumout;
				t1in <= memDo;
				wr_en <= "00100000";
			when "01011" =>
				rd3 <= t1out;
				aluA <= t1out;
				ra3 <= irout(11 downto 9);
				aluOp <= '0';
				aluB <= "0000000000000000";
				wr_en <= "10000001";
			when "01100" =>
				aluA <= r7out;
				aluB <= se10;
				aluOp <= '0';
				t3in <= aluO;
				wr_en <= "00001000";
			when "01101" =>
				aluA <= r7out;
				aluB <= se7;
				t3in <= aluO;
				aluOp <= "0";
				rd3 <= t3out;
				ra3 <= irout(11 downto 9);
				wr_en <= "10001000";
			when "01110" =>
				rd3 <= t3out;
				ra3 <= irout(11 downto 9);
				t3in <= rd2;
				wr_en <= "10001000";
			when "01111" =>
				aluA <= t1out;
				aluB <= se7;
				t3in <= aluO;
				aluOp <= "0";
				wr_en <= "00001000";
			when "10000" =>
				memAddr <= t1out;
				if(irout(0) = '1') then 
					ra3 <= "000"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10001" =>
				memAddr <= t1out;
				if(irout(1) = '1') then 
					ra3 <= "001"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10010" =>
				memAddr <= t1out;
				if(irout(2) = '1') then 
					ra3 <= "010"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10011" =>
				memAddr <= t1out;
				if(irout(3) = '1') then 
					ra3 <= "011"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10100" =>
				memAddr <= t1out;
				if(irout(4) = '1') then 
					ra3 <= "100"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10101" =>
				memAddr <= t1out;
				if(irout(5) = '1') then 
					ra3 <= "101"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10110" =>
				memAddr <= t1out;
				if(irout(6) = '1') then 
					ra3 <= "110"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "10111" =>
				memAddr <= t1out;
				if(irout(7) = '1') then 
					ra3 <= "111"; rd3 <= memDo; wr_en <= "10100000";
				else wr_en <= "00100000";
				end if;
				aluA <= t1out;  
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11000" =>
				memAddr <= t1out;
				if(irout(0) = '1') then	
					ra1 <= "000"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11001" =>
				memAddr <= t1out;
				if(irout(1) = '1') then	
					ra1 <= "001"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11010" =>
				memAddr <= t1out;
				if(irout(2) = '1') then	
					ra1 <= "010"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11011" =>
				memAddr <= t1out;
				if(irout(3) = '1') then	
					ra1 <= "011"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11100" =>
				memAddr <= t1out;
				if(irout(4) = '1') then	
					ra1 <= "100"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11101" =>
				memAddr <= t1out;
				if(irout(5) = '1') then	
					ra1 <= "101"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11110" =>
				memAddr <= t1out;
				if(irout(6) = '1') then	
					ra1 <= "110"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
			when "11111" =>
				memAddr <= t1out;
				if(irout(7) = '1') then	
					ra1 <= "000"; memDi <= rd1; wr_en <= "01100000";
				else wr_en <= "00100000"
				end if;
				aluA <= t1out;
				aluB <= "0000000000000001";
				aluOp <= "0";
				t1in <= aluO;
		end case;
	end process;
	
	opcode <= irout(15 downto 12);
	condition <= irout(1 downto 0);
	C <= aluCo;
	Z <= aluZ;
	eq <= comp_eq;
end architecture;
				
				
				