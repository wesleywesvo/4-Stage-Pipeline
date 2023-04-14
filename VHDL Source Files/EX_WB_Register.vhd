-------------------------------------------------------------------------------
--
-- Title       : EX_WB_Register
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\EX_WB_Register.vhd
-- Generated   : Sat Apr 11 19:08:10 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Takes the ouput values from the ALU and brings it to the next
--  unit. 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {EX_WB_Register} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_WB_Register is
	 port(
	 	 alu_data : in STD_LOGIC_VECTOR(127 downto 0);
	 	 rd_addr_in : in std_logic_vector(4 downto 0);
		 wr_enable_in : in std_logic;
		 instr_in : in std_logic_vector(24 downto 0);
		 
		 instr_out : out std_logic_vector(24 downto 0);
		 wr_enable_out : out std_logic;
		 rd_addr_out : out std_logic_vector(4 downto 0);
		 data_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end EX_WB_Register;

architecture behavioral of EX_WB_Register is
begin
	process (alu_data, rd_addr_in)
	begin
		data_out <= alu_data;
		rd_addr_out <= rd_addr_in;
		wr_enable_out <= wr_enable_in;
		instr_out <= instr_in;
	end process;

end behavioral;
