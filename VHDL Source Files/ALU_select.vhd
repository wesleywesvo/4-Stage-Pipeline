-------------------------------------------------------------------------------
--
-- Title       : ALU_select
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Aldec\My_Designs\ESE345\Project\src\ALU_select.vhd
-- Generated   : Mon Mar 30 15:56:16 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Reads the output values from the previous I-format, R4-format,
--  and R3-format units and determines what value to output based on the correct
--	instruction type. Sends an appropriate "write enable" signal. Occurs every
--  clock cycle on the rising edge.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ALU_select} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_select is
	port(
		 clk : in std_logic;
	 	 instr_type : in std_logic_vector(1 downto 0);
	 	 rd_addr_in : in std_logic_vector(4 downto 0);
	 	 I_in : in STD_LOGIC_VECTOR(127 downto 0); -- instr_type = "0X"
		 R3_in : in STD_LOGIC_VECTOR(127 downto 0); -- instr_type = "11"
		 R4_in : in STD_LOGIC_VECTOR(127 downto 0); -- instr_type = "10"
		 instr_in : in std_logic_vector(24 downto 0);
		 
		 instr_out : out std_logic_vector(24 downto 0);
		 rd_addr_out : out std_logic_vector(4 downto 0);
		 wr_enable_out : out std_logic := '0';
		 alu_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end ALU_select;

architecture behavioral of ALU_select is
begin

	process (clk)
	begin
		if rising_edge(clk) then
			if instr_type = "10" then
				alu_out <= R4_in;
				wr_enable_out <= '1';
		
			elsif instr_type = "11" then
				alu_out <= R3_in;
				
				case instr_in(19 downto 15) is
					when "00000" | "01000" | "10100" | "10101" | "10110" | "10111" | "11000" | "11001" | "11010" | "11011" | "11100" | "11101" | "11110" | "11111"
						=> wr_enable_out <= '0';
					when others => wr_enable_out <= '1';
				end case;
			
			elsif instr_type = "00" or instr_type = "01" then
				alu_out <= I_in;
				wr_enable_out <= '1';
			
			else
				wr_enable_out <= '0';
			
			end if;
			
			instr_out <= instr_in;
			rd_addr_out <= rd_addr_in;
			
		end if;
	end process;

end behavioral;
