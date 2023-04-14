-------------------------------------------------------------------------------
--
-- Title       : Writeback
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\Writeback.vhd
-- Generated   : Sat Apr 11 23:04:54 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Takes the output values from the EX/WB Register and determines
--  if data should be written into the Register File unit based on the write
--  enable signal. Occurs every clock cycle on the rising edge.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Writeback} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity Writeback is
	 port(
		 clk : in STD_LOGIC;
		 data_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rd_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
		 wr_enable_in : in std_logic;
		 instr_in : in std_logic_vector(24 downto 0);
		 
		 instr_out : out std_logic_vector(24 downto 0);
		 data_out : out std_logic_vector(127 downto 0);
		 rd_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
		 wr_enable_out : out std_logic
	     );
end Writeback;

architecture behavioral of Writeback is
begin 
	
	process (clk)
	begin
		if rising_edge(clk) then
			data_out <= data_in;
			rd_addr_out <= rd_addr_in;
			wr_enable_out <= wr_enable_in;
			instr_out <= instr_in;
			
		end if;
	end process;

end behavioral;
