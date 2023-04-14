-------------------------------------------------------------------------------
--
-- Title       : Forwarding_Mux
-- Design      : projv2
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\Forwarding_Mux.vhd
-- Generated   : Wed Apr 15 10:33:53 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Determines which data to forward from the Data Forward unit
-- or the ID/EX Register so that the ALU gets the appropriate inputs.
-- 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Forwarding_Mux} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Forwarding_Mux is
	 port( 
		 wr_rs1 : in STD_LOGIC;
		 wr_rs2 : in STD_LOGIC;
		 wr_rs3 : in STD_LOGIC;
		 rs1_data_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2_data_in : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3_data_in : in STD_LOGIC_VECTOR(127 downto 0);
		 data_in : in std_logic_vector(127 downto 0);
		 
		 wb_data_in : in std_logic_vector(127 downto 0);
		 wb_wr_rs1 : in std_logic;
		 wb_wr_rs2 : in std_logic;
		 wb_wr_rs3 : in std_logic;
		 
		 rs1_data_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_data_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_data_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end Forwarding_Mux;

architecture behavioral of Forwarding_Mux is
begin

	process (wr_rs1, wr_rs2, wr_rs3, rs1_data_in, rs2_data_in, rs3_data_in, data_in, wb_wr_rs1, wb_wr_rs2, wb_wr_rs3, wb_data_in)
	begin
		if wr_rs1 = '1' then
			rs1_data_out <= data_in;
		elsif wb_wr_rs1 = '1' then
			rs1_data_out <= wb_data_in;
		else
			rs1_data_out <= rs1_data_in;
		end if;
	
		if wr_rs2 = '1' then
			rs2_data_out <= data_in;
		elsif wb_wr_rs2 = '1' then
			rs2_data_out <= wb_data_in;
		else
			rs2_data_out <= rs2_data_in;
		end if;
	
		if wr_rs3 = '1' then
			rs3_data_out <= data_in;
		elsif wb_wr_rs3 = '1' then
			rs3_data_out <= wb_data_in;
		else
			rs3_data_out <= rs3_data_in;
		end if;
	end process;
	
end behavioral;
