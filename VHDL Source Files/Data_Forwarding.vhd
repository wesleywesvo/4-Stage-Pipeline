-------------------------------------------------------------------------------
--
-- Title       : Data_Forwarding
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:/Aldec/My_Designs/ESE345/Project/src/Data_Forwarding.vhd
-- Generated   : Thu Apr 16 11:09:29 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Forwards data that was processed in the ALU and has not reached
-- the stage where it is written back into its destination register. Checks the
-- current instruction for register addresses in the ID/EX Register and the
-- destination addresses in the third (execute) and fourth (writeback) stages to
-- see if they are equal.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Data_Forwarding} architecture {Data_Forwarding}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Forwarding is
	 port(
	 	 wr_enable_in : in std_logic; -- if alu output should be written
	 	 rd_addr_in : in STD_LOGIC_VECTOR(4 downto 0); -- address to store alu output
		 instr_in : in std_logic_vector(24 downto 0); -- decode to find rs1,rs2,rs3 addresses
		 data_in : in STD_LOGIC_VECTOR(127 downto 0); -- alu output
		 
		 data_out : out STD_LOGIC_VECTOR(127 downto 0); -- alu output
		 wr_rs1 : out std_logic;
		 wr_rs2 : out std_logic;
		 wr_rs3 : out std_logic;
		 
		 
		 wb_wr_enable_in : in std_logic;
		 wb_data_in : in std_logic_vector(127 downto 0);
		 wb_rd_addr_in : in std_logic_vector(4 downto 0);
		
		 wb_data_out : out std_logic_vector(127 downto 0);
		 wb_wr_rs1 : out std_logic;
		 wb_wr_rs2 : out std_logic;
		 wb_wr_rs3 : out std_logic
	     );
end Data_Forwarding;

architecture behavioral of Data_Forwarding is
begin

	process (wr_enable_in, rd_addr_in, data_in, instr_in)
	begin
		if wr_enable_in = '1' then
			if to_integer(unsigned(rd_addr_in)) = to_integer(unsigned(instr_in(19 downto 15))) then
				wr_rs3 <= '1';
			else
				wr_rs3 <= '0';
			end if;
			
			if to_integer(unsigned(rd_addr_in)) = to_integer(unsigned(instr_in(14 downto 10))) then
				wr_rs2 <= '1';
			else
				wr_rs2 <= '0';
			end if;
			
			if to_integer(unsigned(rd_addr_in)) = to_integer(unsigned(instr_in(9 downto 5))) then
				wr_rs1 <= '1';
			else
				wr_rs1 <= '0';
			end if;
			
			data_out <= data_in;	
		end if;
		
	end process; 
	
	process (wb_wr_enable_in, wb_rd_addr_in, wb_data_in, instr_in)
	begin
		if wb_wr_enable_in = '1' then
			if to_integer(unsigned(wb_rd_addr_in)) = to_integer(unsigned(instr_in(19 downto 15))) then
				wb_wr_rs3 <= '1';
			else
				wb_wr_rs3 <= '0';
			end if;
		
			if to_integer(unsigned(wb_rd_addr_in)) = to_integer(unsigned(instr_in(14 downto 10))) then
				wb_wr_rs2 <= '1';
			else
				wb_wr_rs2 <= '0';
			end if;
		
			if to_integer(unsigned(wb_rd_addr_in)) = to_integer(unsigned(instr_in(9 downto 5))) then
				wb_wr_rs1 <= '1';
			else
				wb_wr_rs1 <= '0';
			end if;
			
			wb_data_out <= wb_data_in;	
		end if;
		
	end process;

end behavioral;