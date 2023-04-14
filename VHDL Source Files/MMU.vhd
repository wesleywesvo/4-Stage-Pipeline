-------------------------------------------------------------------------------
--
-- Title       : MMU
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\MMU.vhd
-- Generated   : Sat Apr 11 23:28:32 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Structural architecture of the pipelined multimedia unit.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MMU} architecture {structural}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.buff_arr.all;

entity MMU is
	 port(
	 	 clk : in STD_LOGIC;
		 instruction_input : in instr_buff;
		 
		 ID_rs1_data : out std_logic_vector(127 downto 0);
		 ID_rs2_data : out std_logic_vector(127 downto 0);
		 ID_rs3_data : out std_logic_vector(127 downto 0);
		 ID_rd_data : out std_logic_vector(127 downto 0);
		 EX_rs1_data : out std_logic_vector(127 downto 0);
		 EX_rs2_data : out std_logic_vector(127 downto 0);
		 EX_rs3_data : out std_logic_vector(127 downto 0);
		 EX_rd_data : out std_logic_vector(127 downto 0);
		 
		 IF_instruction : out std_logic_vector(24 downto 0);
		 ID_instruction : out std_logic_vector(24 downto 0);
		 EX_instruction : out std_logic_vector(24 downto 0);
		 WB_instruction : out std_logic_vector(24 downto 0);
		 WB_data : out std_logic_vector(127 downto 0);
		 WB_rd_addr : out std_logic_vector(4 downto 0);
		 WB_wr_enable : out std_logic
	     );
end MMU;

architecture structural of MMU is
-- Stage 1 = Instruction_Buffer + IF_ID_Register
signal instruction : std_logic_vector(24 downto 0);

signal instr_if_id_reg : std_logic_vector(24 downto 0);
signal rs1_addr_if_id_reg : std_logic_vector(4 downto 0);
signal rs2_addr_if_id_reg : std_logic_vector(4 downto 0);
signal rs3_addr_if_id_reg : std_logic_vector(4 downto 0);
signal rd_addr_if_id_reg : std_logic_vector(4 downto 0);
-- Stage 2 = Register_File + ID_EX_Register
signal rs1_rf_id_ex : std_logic_vector(127 downto 0);
signal rs2_rf_id_ex : std_logic_vector(127 downto 0);
signal rs3_rf_id_ex : std_logic_vector(127 downto 0);
signal rd_rf_id_ex : std_logic_vector(127 downto 0);
signal rd_addr_rf_id_ex : std_logic_vector(4 downto 0);
signal instr_rf_id_ex : std_logic_vector(24 downto 0);
-- Stage 3 = I_Type_Instr + R4_Type_Instr + R3_Type_Instr + ALU_select + EX_WB_Register
signal rs1_id_ex_fm : std_logic_vector(127 downto 0);
signal rs2_id_ex_fm : std_logic_vector(127 downto 0);
signal rs3_id_ex_fm : std_logic_vector(127 downto 0);

signal rs1_fm_alu : std_logic_vector(127 downto 0);
signal rs2_fm_alu : std_logic_vector(127 downto 0);
signal rs3_fm_alu :	std_logic_vector(127 downto 0);

signal rd_id_ex_alu : std_logic_vector(127 downto 0);
signal rd_addr_id_ex_alu : std_logic_vector(4 downto 0);
signal instr_type : std_logic_vector(1 downto 0);
signal ld_index : std_logic_vector(2 downto 0);
signal immediate : std_logic_vector(15 downto 0);
signal R4_opcode : std_logic_vector(2 downto 0);
signal R3_opcode : std_logic_vector(7 downto 0);
signal instr_id_ex_alu : std_logic_vector(24 downto 0);

signal data_out_i : std_logic_vector(127 downto 0);
signal data_out_R4 : std_logic_vector(127 downto 0);
signal data_out_r3 : std_logic_vector(127 downto 0);

signal alu_out_alu_ex_wb : std_logic_vector(127 downto 0);
signal rd_addr_alu_ex_wb : std_logic_vector(4 downto 0);
signal wr_enable_alu_ex_wb : std_logic;
signal instr_alu_ex_wb : std_logic_vector(24 downto 0);

signal data_out_ex_wb : std_logic_vector(127 downto 0);
signal rd_addr_ex_wb : std_logic_vector(4 downto 0);
signal wr_enable_ex_wb : std_logic;

signal instr_ex_wb : std_logic_vector(24 downto 0);
-- Stage 4 = Writeback
signal rd_addr_wb : std_logic_vector(4 downto 0);
signal data_wb : std_logic_vector(127 downto 0);
signal wr_enable_wb : std_logic;
signal instr_wb : std_logic_vector(24 downto 0);
-- Forwarding unit
signal data_sig : std_logic_vector(127 downto 0);
signal wr_rs1_sig : std_logic;
signal wr_rs2_sig : std_logic;
signal wr_rs3_sig :	std_logic;

signal wb_data_sig : std_logic_vector(127 downto 0);
signal wb_wr_rs1_sig : std_logic;
signal wb_wr_rs2_sig : std_logic;
signal wb_wr_rs3_sig :	std_logic;

begin
	u1 : entity work.Instruction_Buffer(behavioral) port map (
		clk => clk,
		instr_in => instruction_input,
		instr_out => instruction
		);
		IF_instruction <= instruction;
		
	u2 : entity work.IF_ID_Register(behavioral) port map (
		instr_in => instruction,
		instr_out => instr_if_id_reg,
		rs1_addr => rs1_addr_if_id_reg,
		rs2_addr => rs2_addr_if_id_reg,
		rs3_addr => rs3_addr_if_id_reg,
		rd_addr => rd_addr_if_id_reg
		);
		
	u3 : entity work.Register_File(behavioral) port map (
		clk => clk,
		instr_in => instr_if_id_reg,
		rs1_addr => rs1_addr_if_id_reg,
		rs2_addr => rs2_addr_if_id_reg,
		rs3_addr => rs3_addr_if_id_reg,
		rd_addr_in => rd_addr_if_id_reg,
		
		rs1_out => rs1_rf_id_ex,
		rs2_out => rs2_rf_id_ex,
		rs3_out => rs3_rf_id_ex,
		rd_out => rd_rf_id_ex,
		rd_addr_out => rd_addr_rf_id_ex,
		instr_out => instr_rf_id_ex,
		
		wr_enable => wr_enable_wb,
		reg_addr => rd_addr_wb,
		data => data_wb
		);
		ID_Instruction <= instr_rf_id_ex;
		ID_rs1_data <= rs1_rf_id_ex;
		ID_rs2_data <= rs2_rf_id_ex;
		ID_rs3_data <= rs3_rf_id_ex;
		ID_rd_data <= rd_rf_id_ex;
		
	u4 : entity work.ID_EX_Register(behavioral) port map (
		rs1_in => rs1_rf_id_ex,
		rs2_in => rs2_rf_id_ex,
		rs3_in => rs3_rf_id_ex,
		rd_in => rd_rf_id_ex,
		rd_addr_in => rd_addr_rf_id_ex,
		instr_in => instr_rf_id_ex,
		
		rs1_out => rs1_id_ex_fm,
		rs2_out => rs2_id_ex_fm,
		rs3_out => rs3_id_ex_fm,
		rd_out => rd_id_ex_alu,
		rd_addr_out => rd_addr_id_ex_alu,
		instr_type => instr_type,
		ld_index => ld_index,
		immediate => immediate,
		R4_opcode => R4_opcode,
		R3_opcode => R3_opcode,
		instr_out => instr_id_ex_alu
		);
		
	u5 : entity work.Forwarding_Mux(behavioral) port map (
		wr_rs1 => wr_rs1_sig,
		wr_rs2 => wr_rs2_sig,
		wr_rs3 => wr_rs3_sig,
		data_in => data_sig,
		
		rs1_data_in => rs1_id_ex_fm,
		rs2_data_in => rs2_id_ex_fm,
		rs3_data_in => rs3_id_ex_fm,
		
		wb_wr_rs1 => wb_wr_rs1_sig,
		wb_wr_rs2 => wb_wr_rs2_sig,
		wb_wr_rs3 => wb_wr_rs3_sig,
		wb_data_in => wb_data_sig,
		
		rs1_data_out =>	rs1_fm_alu,
		rs2_data_out =>	rs2_fm_alu,
		rs3_data_out => rs3_fm_alu
		);	
		EX_rs1_data <= rs1_fm_alu;
		EX_rs2_data <= rs2_fm_alu;
		EX_rs3_data <= rs3_fm_alu;
		EX_rd_data <= rd_id_ex_alu;
		
	u6 : entity work.I_Type_Instr(behavioral) port map (
		instr_type => instr_type,
		ld_index => ld_index,
		immediate => immediate,
		rd => rd_id_ex_alu,
		data_out => data_out_i
		);
		
	u7 : entity work.R4_Type_Instr(behavioral) port map (
		instr_type => instr_type,
		R4_opcode => R4_opcode,
		rs1 => rs1_fm_alu,
		rs2 => rs2_fm_alu,
		rs3 => rs3_fm_alu,
		data_out => data_out_R4
		);
		
	u8 : entity work.R3_Type_Instr(Behavioral) port map (
		instr_type => instr_type,
		R3_opcode => R3_opcode,
		rs1 => rs1_fm_alu,
		rs2 => rs2_fm_alu,
		data_out => data_out_R3
		);
		
	u9 : entity work.ALU_select(behavioral) port map (
		clk => clk,
		instr_type => instr_type,
		I_in => data_out_i,
		R3_in => data_out_R3,
		R4_in => data_out_R4,
		rd_addr_in => rd_addr_id_ex_alu,
		instr_in => instr_id_ex_alu,
		 
		wr_enable_out => wr_enable_alu_ex_wb,
		alu_out => alu_out_alu_ex_wb,
		rd_addr_out => rd_addr_alu_ex_wb,
		
		instr_out => instr_alu_ex_wb
		);
		EX_Instruction <= instr_alu_ex_wb;
		
	u10 : entity work.Data_Forwarding(behavioral) port map (
		wr_enable_in => wr_enable_alu_ex_wb,
		data_in => alu_out_alu_ex_wb,
		rd_addr_in => rd_addr_alu_ex_wb,
		instr_in => instr_id_ex_alu,
		
		data_out => data_sig,
		wr_rs1 => wr_rs1_sig,
		wr_rs2 => wr_rs2_sig,
		wr_rs3 => wr_rs3_sig,
		
		wb_wr_enable_in => wr_enable_wb,
		wb_data_in => data_wb,
		wb_rd_addr_in => rd_addr_wb,
		
		wb_data_out	=> wb_data_sig,
		wb_wr_rs1 => wb_wr_rs1_sig,
		wb_wr_rs2 => wb_wr_rs2_sig,
		wb_wr_rs3 => wb_wr_rs3_sig
		);
		
	u11 : entity work.EX_WB_Register(behavioral) port map (
		alu_data => alu_out_alu_ex_wb,
		rd_addr_in => rd_addr_alu_ex_wb,
		wr_enable_in => wr_enable_alu_ex_wb,
		instr_in => instr_alu_ex_wb,
		
		wr_enable_out => wr_enable_ex_wb,
		data_out => data_out_ex_wb,
		rd_addr_out => rd_addr_ex_wb,
		instr_out => instr_ex_wb
		);
		
	u12 : entity work.Writeback(behavioral) port map (
		clk => clk,
		data_in => data_out_ex_wb,
		rd_addr_in => rd_addr_alu_ex_wb,
		wr_enable_in => wr_enable_ex_wb,
		instr_in => instr_ex_wb,
		
		wr_enable_out => wr_enable_wb,
		rd_addr_out => rd_addr_wb,
		data_out => data_wb,
		
		instr_out => instr_wb
		);
		WB_instruction <= instr_wb;
		WB_data <= data_wb;
		WB_rd_addr <= rd_addr_wb;
		WB_wr_enable <= wr_enable_wb;
		
end structural;
