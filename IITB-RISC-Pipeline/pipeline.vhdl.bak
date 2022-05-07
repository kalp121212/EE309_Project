library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is 
	port(
		clk_main, rst_main : in std_logic;
		output_dummy : out std_logic
	);
end entity;

architecture final of pipeline is

	component instr_fetch is
		port(
			clk, reset, stall : in std_logic;
			instr, pc_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component instr_decode is 
		port(
			clk, reset, stall : in std_logic;
			instr, pc_in : in std_logic_vector(15 downto 0);
			opcode : out std_logic_vector(3 downto 0);
			ra, rb, rc : out std_logic_vector(2 downto 0);
			condition : out std_logic_vector(1 downto 0);
			imm6 : out std_logic_vector(15 downto 0);
			imm9 : out std_logic_vector(15 downto 0);
			pc_out : out std_logic_vector(15 downto 0)   -- write into PC
		);
	end component;
	
	component reg_read is   
		port(
			clk, reset, stall : in std_logic;
			opcode_in : in std_logic_vector(3 downto 0);
			ra_in, rb_in, rc_in : in std_logic_vector(2 downto 0);  -- connect through RF
			cond_in : in std_logic_vector(1 downto 0);
			imm6_in : in std_logic_vector(15 downto 0);
			imm9_in : in std_logic_vector(15 downto 0);
			pc_in, ra_val_in, rb_val_in : in std_logic_vector(15 downto 0);

			opcode_out : out std_logic_vector(3 downto 0);
			rc_out : out std_logic_vector(2 downto 0);
			cond_out : out std_logic_vector(1 downto 0);
			imm6_out : out std_logic_vector(15 downto 0);
			imm9_out : out std_logic_vector(15 downto 0);
			pc_out, ra_val_out, rb_val_out: out std_logic_vector(15 downto 0)
		);
	end component;
		
	component execute is
		port(
			clk, reset, stall : in std_logic;
			pc_in : in std_logic_vector(15 downto 0);
			imm6_in : in std_logic_vector(15 downto 0);
			imm9_in : in std_logic_vector(15 downto 0);
			opcode_in : in std_logic_vector(3 downto 0);
			ra,rb : in std_logic_vector(15 downto 0);
			cond_in : in std_logic_vector(1 downto 0);
			rc_in : in std_logic_vector(2 downto 0);

			opcode_out : out std_logic_vector(3 downto 0);
			rc_out : out std_logic_vector(2 downto 0);
			cond_out : out std_logic_vector(1 downto 0);
			alu_out : out std_logic_vector(15 downto 0);
			Z_out,carry_out,eq_out : out std_logic;
			ra_out : out std_logic_vector(15 downto 0);
			pc_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component memory_access is 
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
			reg_out : out std_logic_vector(2 downto 0);  --ma_addr
			carry_out,z_out: out std_logic;
			cond_out : out std_logic_vector(1 downto 0);
			pc_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component write_back is 
		port(
			clk, reset, stall : in std_logic;
			opcode_in: in std_logic_vector(15 downto 0);
			pc_in : in std_logic_vector(15 down to 0);
			reg_in : in std_logic_vector(2 downto 0);
			alu_out : in std_logic_vector(15 downto 0);
			Z_in,carry_in : in std_logic;
			cond_in : in std_logic_vector(1 downto 0);

			reg_out : out std_logic_vector(2 downto 0);  --wb_addr
			reg_data : out std_logic_vector(15 downto 0);  --wb_data
			reg_write : out std_logic;  --wb_en
			pc_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component IF_ID_reg is
		port(
			clk, reset, write_enable : in std_logic;
			instr_in, pc_in : in std_logic_vector(15 downto 0);
			instr_out, pc_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component ID_RR_reg is
		port(
			clk, reset, write_enable : std_logic;
			----
			pc_in : in std_logic_vector(15 downto 0);
			opcode_in : in std_logic_vector(3 downto 0);
			ra_in, rb_in, rc_in : in std_logic_vector(2 downto 0);
			cond_in : in std_logic_vector(1 downto 0);
			imm6_in : in std_logic_vector(15 downto 0);
			imm9_in : in std_logic_vector(15 downto 0);
			----
			pc_out : out std_logic_vector(15 downto 0);
			opcode_out : out std_logic_vector(3 downto 0);
			ra_out, rb_out, rc_out : out std_logic_vector(2 downto 0);
			cond_out : out std_logic_vector(1 downto 0);
			imm6_out : out std_logic_vector(15 downto 0);
			imm9_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component RR_EX_reg is
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
		);
	end component;
	
	component EX_MA_reg is
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
			reg_out : out std_logic_vector(2 downto 0);  --reg4_addr
			ra_out : out std_logic_vector(15 downto 0);
			cond_out : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component MA_WB_reg is
		port(
			clk, reset, write_enable : in std_logic;

			alu_out_in : in std_logic_vector(15 downto 0);
			opcode_in : in std_logic_vector(3 downto 0);
			reg_out_in : in std_logic_vector(2 downto 0);
			carry_in,z_in : in std_logic;
	        -- next_instr : in std_logic_vector(15 downto 0);
			cond_in : in std_logic_vector(1 downto 0);
			pc_in : in std_logic_vector(15 downto 0)

			opcode_out: out std_logic_vector(3 downto 0);
			pc_out : out std_logic_vector(15 downto 0);
			reg_out : out std_logic_vector(2 downto 0);   --reg5_addr
			alu_out : out std_logic_vector(15 downto 0);
			Z_out,carry_out : out std_logic;
			cond_out : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component register_file is 
		port(
			A1 : in std_logic_vector(2 downto 0);
			A2 : in std_logic_vector(2 downto 0);
			A3 : in std_logic_vector(2 downto 0);
			D3 : in std_logic_vector(15 downto 0);
			PC : in std_logic_vector(15 downto 0);
			write_enable : in std_logic;
			write_pc : in std_logic;
			read_enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			D1 : out std_logic_vector(15 downto 0);
			D2 : out std_logic_vector(15 downto 0);
			R7_PC : out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal stall1, stall2, stall3, stall4, stall5, stall6 : std_logic := '0';
	signal ex_z,ex_c,ex_eq,reg4_c,reg4_z,reg4_eq,ma_c,ma_z,reg5_c,reg5_z,wb_en : std_logic;
	signal if_instr,if_pc,reg1_instr,reg1_pc,id_imm6,id_imm9,id_pc,reg2_imm6,reg2_imm9,reg2_pc,rr_imm6,rr_imm9,rr_pc,rr_val1,rr_val2,reg5_pc,reg5_alu : std_logic_vector(15 downto 0);
	signal reg3_imm6,reg3_imm9,reg3_pc,reg3_val1,reg3_val,ex_alu,ex_imm9,ex_pc,ex_val,reg4_pc,reg4_alu,reg4_ra,ma_alu,ma_pc,wb_data,wb_pc,rfd1,rfd2,rfpc : std_logic_vector(15 downto 0);
	signal id_opcode,reg2_opcode,rr_opcode,reg3_opcode,ex_opcode,reg4_opcode,ma_opcode,reg5_opcode : std_logic_vector(3 downto 0);
	signal id_ra,id_rb,id_rc,reg2_ra,reg2_rb,reg2_rc,rr_rc,reg3_rc,ex_rc,reg4_addr,ma_addr,reg5_addr,wb_addr : std_logic_vector(2 downto 0);
	signal id_cond,reg2_cond,rr_cond,reg3_cond,ex_cond,reg4_cond,ma_cond,reg5_cond : std_logic_vector(1 downto 0);
	
	
	
begin
	
	stage1 : instr_fetch port map(clk => clk_main, reset => rst_main, stall => stall1, instr => if_instr, pc_out => if_pc);
	pipe_reg1 : IF_ID_reg port map(clk => clk_main, reset => rst_main, write_enable => not stall1, instr_in => if_instr, pc_in => if_pc, instr_out => reg1_instr, pc_out => reg1_pc); 
	stage2 : instr_decode port map(clk => clk_main, reset => rst_main, stall => stall2, instr => reg1_instr, pc_in => reg1_pc, opcode => id_opcode, ra => id_ra, rb => id_rb, rc => id_rc, condition => id_cond, imm6 => id_imm6, imm9 => id_imm9, pc_out => id_pc);
	pipe_reg2 : ID_RR_reg port map(clk => clk_main, reset => rst_main, write_enable => not stall2, pc_in => id_pc, opcode_in => id_opcode, ra_in => id_ra, rb_in => id_rb, rc_in => id_rc, cond_in => id_cond, imm6_in => id_imm6, imm9_in => id_imm9, pc_out => reg2_pc, opcode_out => reg2_opcode, ra_out => reg2_ra, rb_out => reg2_rb, rc_out => reg2_rc, cond_out => reg2_cond, imm6_out => reg2_imm6, imm9_out => reg2_imm9);
	stage3 : reg_read port map(clk=>clk_main, reset=>rst_main, stall=>stall3, opcode_in=>reg2_opcode, ra_in=>reg2_ra, rb_in=>reg2_rb, rc_in=>reg2_rc, cond_in=>reg2_cond, imm6_in=>reg2_imm6, imm9_in=>reg2_imm9, pc_in=>reg2_pc, ra_val_in=>rfd1, rb_val_in=>rfd2, opcode_out=>rr_opcode, rc_out=>rr_rc, cond_out=>rr_cond, imm6_out=>rr_imm6, imm9_out=>rr_imm9, pc_out=>rr_pc, ra_val_out=>rr_val1, rb_val_out=>rr_val2);
	rf : register_file port map(A1=>reg2_ra, A2=>reg2_rb, A3=>wb_addr, D3=>wb_data, PC=>id_pc, write_enable=>wb_en, write_pc=>not stall2, read_enable=>'1', reset=>rst_main, clk=>clk_main, D1=>rfd1, D2=>rfd2, r7_pc=>rfpc);
	pipe_reg3 : RR_EX_reg port map(clk=>clk_main, reset=>rst_main, write_enable=>not stall3, opcode_in=>rr_opcode, rc_in=>rr_rc, cond_in=>rr_cond, imm6_in=>rr_imm6, imm9_in=>rr_imm9, pc_in=>rr_pc, ra_val_in=>rr_val1, rb_val_in=>rr_val2, pc_out=>reg3_pc, imm6_out=>reg3_imm6, imm9_out=>reg3_imm9, opcode_out=>reg3_opcode, ra=>reg3_val1, rb=>reg3_val2, cond_out=>reg3_cond, rc_out=>reg3_rc);
	stage4 : execute port map(clk=>clk_main, reset=>rst_main, stall=>stall4, pc_in=>reg3_pc, imm6_in=>reg3_imm6, imm9_in=>reg3_imm9, opcode_in=>reg3_opcode, ra=>reg3_val1, rb=>reg3_val2, cond_in=>reg3_cond, rc_in=>reg3_cond, opcode_out=>ex_opcode, rc_out=>ex_rc, cond_out=>ex_cond, alu_out=>ex_alu, z_out=>ex_z, carry_out=>ex_c, eq_out=>ex_eq, ra_out=>ex_val, pc_out=>ex_pc);
	pipe_reg4 : EX_MA_reg port map(clk=>clk_main, reset=>rst_main, write_enable=>not stall4, opcode_in=>ex_opcode, rc_in=>ex_rc, cond_in=>ex_cond, alu_out_in=>ex_alu, z_in=>ex_z, carry_in=>ex_c, eq_in=>ex_eq, ra_in=>ex_val, pc_in=>ex_pc, pc_out=>reg4_pc, alu_out=>reg4_alu, opcode_out=>reg4_opcode, carry_out=> reg4_c, z_out=>reg4_z, eq_out=>reg4_eq, reg_out=> reg4_addr, ra_out=>reg4_ra, cond_out=> reg4_cond);
	stage5 : memory_access port map(clk=>clk_main, reset=>rst_main, stall=>stall5, pc_in=>reg4_pc, alu_out_in=>reg4_alu, opcode_in=>reg4_opcode, carry_in=>reg4_c, z_in=>reg4_z, eq_in=>reg4_eq, reg_in=>reg4_addr, ra_in=>reg4_ra, cond_in=>reg4_cond, alu_out=>ma_alu, opcode_out=>ma_opcode, reg_out=>ma_addr, carry_out=>ma_c, z_out=>reg4_z, cond_out=>reg4_cond, pc_out=>reg4_pc);\
	pipe_reg5 : MA_WB_reg port map(clk=>clk_main, reset=>rst_main, write_enable=>not stall5, alu_out_in=>ma_alu, opcode_in=>ma_opcode, reg_out_in=>ma_addr, carry_in=>ma_c, z_in=>ma_z, cond_in=>ma_cond, pc_in=>ma_pc, opcode_out=>reg5_opcode, pc_out=>reg5_pc, reg_out=> reg5_addr, alu_out=>reg5_alu, z_out=>reg5_z, carry_out=>reg5_c, cond_out=>reg5_cond);
	stage6 : write_back port map(clk=>clk_main, reset=>rst_main, stall=>stall6, opcode_in=>reg5_opcode, pc_in=>reg5_pc, reg_in=>reg5_addr, alu_out=>reg5_alu, z_in=>reg5_z, carry_in=>reg5_c, cond_in=>reg5_cond, reg_out=>wb_addr, reg_data=>wb_data, reg_write=>wb_en, pc_out=>wb_pc);
	
	output_dummy <= '1';
	
end architecture;
		
		