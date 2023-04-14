					 -------------------------------------------------------------------------------
--
-- Title       : Register_File
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\Register_File.vhd
-- Generated   : Sat Apr 11 22:48:25 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Takes the outputs from the IF/ID Register and outputs the
-- corresponding register values based on the input address. Will also write into
-- a register, if applicable, so that the more recent value of a register is used.
-- Occurs every clock cycle on the rising edge.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Register_File} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
	 port(
		 clk : in STD_LOGIC;
		 instr_in : in STD_LOGIC_VECTOR(24 downto 0);
		 -- 32 total registers = address of 5-bits
		 rs1_addr : in STD_LOGIC_VECTOR(4 downto 0);
		 rs2_addr : in STD_LOGIC_VECTOR(4 downto 0);
		 rs3_addr : in STD_LOGIC_VECTOR(4 downto 0);
		 rd_addr_in : in STD_LOGIC_VECTOR(4 downto 0);
		 
		 rs1_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs2_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rs3_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rd_out : out STD_LOGIC_VECTOR(127 downto 0);
		 rd_addr_out : out STD_LOGIC_VECTOR(4 downto 0);
		 instr_out : out STD_LOGIC_VECTOR(24 downto 0);
		 
		 reg_addr : in STD_LOGIC_VECTOR(4 downto 0); -- address of register to be written into
		 data : in STD_LOGIC_VECTOR(127 downto 0); -- data to be written
		 wr_enable : in STD_LOGIC
	     );
end Register_File;

architecture behavioral of Register_File is	 
	type reg_arr is array(0 to 31) of std_logic_vector(127 downto 0);
	signal regFile : reg_arr := (others => (others => '0')); -- initialize all to 0	
	
	signal rs1_sig, rs2_sig, rs3_sig, rd_sig : std_logic_vector(127 downto 0);
	
begin
	
	process (clk)
	begin
		
		-- write to register on rising edge of clock -> first half of cycle
		if rising_edge(clk) then
			if wr_enable = '1' then
				regFile(to_integer(unsigned(reg_addr))) <= data; 
			end if;	
			
			instr_out <= instr_in;
			rd_addr_out <= rd_addr_in;
			rs1_out <= rs1_sig;
			rs2_out <= rs2_sig;
			rs3_out <= rs3_sig;
			rd_out <= rd_sig;
			
		end if;
		
		-- read on falling edge of clock -> second half	of cycle
		if falling_edge(clk) then
			rs1_sig <= regFile(to_integer(unsigned(rs1_addr)));
			rs2_sig <= regFile(to_integer(unsigned(rs2_addr)));
			rs3_sig <= regFile(to_integer(unsigned(rs3_addr)));
			rd_sig <= regFile(to_integer(unsigned(rd_addr_in)));
		end if;
		
	end process;

end behavioral;
