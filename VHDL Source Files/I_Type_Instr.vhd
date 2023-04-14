-------------------------------------------------------------------------------
--
-- Title       : I_Type_Instr
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Aldec\My_Designs\ESE345\Project\src\I_Type_Instr.vhd
-- Generated   : Mon Mar 30 15:19:35 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Reads the values from the ID/EX Register unit to determine if
--  the instruction is "Immediate-format". Performs appropriate operations if
--  applicable and outputs the value.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {I_Type_Instr} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity I_Type_Instr is
	 port(
		 instr_type : in STD_LOGIC_VECTOR(1 downto 0);
		 ld_index : in STD_LOGIC_VECTOR(2 downto 0);
		 immediate : in STD_LOGIC_VECTOR(15 downto 0);
		 rd : in std_logic_vector(127 downto 0);
		 
		 data_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end I_Type_Instr;

architecture behavioral of I_Type_Instr is
begin

	process (instr_type, ld_index, immediate)
	
	begin
		if instr_type = "00" or instr_type = "01" then
			if ld_index = "000" then
				data_out <= rd(127 downto 16) & immediate;
				
			elsif ld_index = "001" then
				data_out <= rd(127 downto 32) & immediate & rd(15 downto 0);
				
			elsif ld_index = "010" then
				data_out <= rd(127 downto 48) & immediate & rd(31 downto 0);
				
			elsif ld_index = "011" then
				data_out <= rd(127 downto 64) & immediate & rd(47 downto 0);
				
			elsif ld_index = "100" then
				data_out <= rd(127 downto 80) & immediate & rd(63 downto 0);
				
			elsif ld_index = "101" then
				data_out <= rd(127 downto 96) & immediate & rd(79 downto 0);
				
			elsif ld_index = "110" then
				data_out <= rd(127 downto 112) & immediate & rd(95 downto 0);
				
			elsif ld_index = "111" then
				data_out <= immediate & rd(111 downto 0);
			
			end if;
			
		end if;
	end process;
	
	--rd_addr_out <= rd_addr_in;

end behavioral;
