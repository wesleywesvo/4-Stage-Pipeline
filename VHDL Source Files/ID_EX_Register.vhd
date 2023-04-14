-------------------------------------------------------------------------------
--
-- Title       : ID_EX_Register
-- Design      : Project
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\ID_EX_Register.vhd
-- Generated   : Wed Apr  1 15:04:39 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Takes the outputs from the Register File unit and brings it to
--  the next unit. Decodes the instruction to output information on what type of 
--  instruction format the input instruction is.  
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ID_EX_Register} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Register is
	port(
		 --clk : in std_logic;
		 rs1_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rd_in : in std_logic_vector(127 downto 0);
		 rd_addr_in : in std_logic_vector(4 downto 0);
		 instr_in : in STD_LOGIC_VECTOR(24 downto 0);
		 
		 rs1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rd_out : out std_logic_vector(127 downto 0);
		 rd_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
		 instr_out : out std_logic_vector(24 downto 0);
		 
		 -- decode instructions
		 instr_type : out std_logic_vector(1 downto 0); -- instruction type
		 ld_index : out std_logic_vector(2 downto 0); -- values for I-type
		 immediate : out std_logic_vector(15 downto 0);
		 R4_opcode : out std_logic_vector(2 downto 0); -- value for R4-type
		 R3_opcode : out std_logic_vector(7 downto 0) -- value for R3-type
	     );
end ID_EX_Register;

architecture behavioral of ID_EX_Register is
begin
	
	process (rs1_in, rs2_in, rs3_in, rd_addr_in, instr_in)
	begin
		
		rs1_out <= rs1_in;
		rs2_out <= rs2_in;
		rs3_out <= rs3_in;
		rd_out <= rd_in;
		rd_addr_out <= rd_addr_in;
		instr_out <= instr_in;
			
	 	instr_type <= instr_in(24 downto 23);
		ld_index <= instr_in(23 downto 21);
		immediate <= instr_in(20 downto 5);
		R4_opcode <= instr_in(22 downto 20);
		R3_opcode <= instr_in(22 downto 15);
		
	end process;

end behavioral;
