-------------------------------------------------------------------------------
--
-- Title       : Instruction_Buffer
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\Instruction_Buffer.vhd
-- Generated   : Mon Apr  6 11:44:51 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : The instruction buffer takes an input instruction of size (24:0)
-- 	based on the current PC, outputs the instruction, and increments PC. Occurs
-- 	every clock cycle on the rising edge.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Instruction_Buffer} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

package buff_arr is
	type instr_buff is array(0 to 63) of std_logic_vector (24 downto 0);
end package buff_arr;	  

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.buff_arr.all;

entity Instruction_Buffer is
	 port(
		instr_in : in instr_buff; 
	   	clk : in std_logic;
		   
		instr_out : out STD_LOGIC_VECTOR(24 downto 0)
		);
end Instruction_Buffer;

architecture behavioral of Instruction_Buffer is 

signal PC : std_logic_vector(5 downto 0) := "000000";

begin
	
	process (clk)
	
	begin
		if rising_edge(clk) then
			instr_out <= instr_in(to_integer(unsigned(PC)));
			PC <= std_logic_vector(to_unsigned(to_integer(unsigned(PC) + 1), 6));	

		end if;
		
	end process;
	
end behavioral;
