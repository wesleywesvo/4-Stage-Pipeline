-------------------------------------------------------------------------------
--
-- Title       : IF_ID_Register
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\IF_ID_Register.vhd
-- Generated   : Sat Apr 11 12:24:47 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Takes the output instruction from the Instruction Buffer unit
--	and brings it to the next unit. Decodes the instruction to find all possible 
--  register addresses that could be used so that the Register File unit is prepared.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {IF_ID_Register} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID_Register is
	 port(
		 --clk : in STD_LOGIC;
		 instr_in : in STD_LOGIC_VECTOR(24 downto 0);
		 
		 instr_out : out std_logic_vector(24 downto 0); 
		 rs1_addr : out std_logic_vector(4 downto 0); -- register addresses
		 rs2_addr : out std_logic_vector(4 downto 0);
		 rs3_addr : out std_logic_vector(4 downto 0);
		 rd_addr : out std_logic_vector(4 downto 0)
	     );
end IF_ID_Register;

architecture behavioral of IF_ID_Register is
signal reg_in : std_logic_vector(24 downto 0);
begin

	process (instr_in)
	begin
		
		rd_addr <= instr_in(4 downto 0);
		rs1_addr <= instr_in(9 downto 5);
		rs2_addr <= instr_in(14 downto 10);
		rs3_addr <= instr_in(19 downto 15);
		instr_out <= instr_in;
			

	end process;

end behavioral;
