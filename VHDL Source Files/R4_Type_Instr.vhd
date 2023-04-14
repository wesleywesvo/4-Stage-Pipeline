-------------------------------------------------------------------------------
--
-- Title       : R4_Type_Instr
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Aldec\My_Designs\ESE345\Project\src\R4_Type_Instr.vhd
-- Generated   : Mon Mar 30 15:42:05 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Reads the values from the ID/EX Register unit to determine if
--  the instruction is "R4-format". Performs appropriate operations if
--  applicable and outputs the value.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {R4_Type_Instr} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity R4_Type_Instr is
	 port(
		 instr_type : in STD_LOGIC_VECTOR(1 downto 0);
		 R4_opcode : in STD_LOGIC_VECTOR(2 downto 0);
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs3 : in STD_LOGIC_VECTOR(127 downto 0);
		 
		 data_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end R4_Type_Instr;

architecture behavioral of R4_Type_Instr is
begin

	process (instr_type, R4_opcode, rs1, rs2, rs3) 

		variable signed_product : integer := 0 ; -- R4 Instructions product
		variable signed_sum : integer := 0; -- sum 
		
		variable product_sig : std_logic_vector(63 downto 0);
		variable sum_sig : std_logic_vector(63 downto 0);
	
	begin
		-- R4 Instruction type --
		if instr_type = "10" then
			-- Signed Integer Multiply-Add Low with Saturation --
			-- Multiply low 16-bits of rs3 and rs2 (each 32-bit field) then add 32-bits of rs1 with saturation --
			if R4_opcode(2 downto 0) = "000" then
				-- Pack 3 --
				signed_product := to_integer(signed(rs3(111 downto 96))) * to_integer(signed(rs2(111 downto 96))); 				
				signed_sum := signed_product + to_integer(signed(rs1(127 downto 96)));
				if signed_sum < 0 and (rs1(127) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(127 downto 96) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum > 0 and (rs1(127) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(127 downto 96) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 96) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 2 --
				signed_product := to_integer(signed(rs3(79 downto 64))) * to_integer(signed(rs2(79 downto 64)));
				signed_sum := signed_product + to_integer(signed(rs1(95 downto 64)));
				if signed_sum < 0 and (rs1(95) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(95 downto 64) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum > 0 and (rs1(95) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(95 downto 64) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 64) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 1 --
				signed_product := to_integer(signed(rs3(47 downto 32))) * to_integer(signed(rs2(47 downto 32)));				
				signed_sum := signed_product + to_integer(signed(rs1(63 downto 32)));
				if signed_sum < 0 and (rs1(63) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(63 downto 32) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum > 0 and (rs1(63) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(63 downto 32) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 32) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 0 --
				signed_product := to_integer(signed(rs3(15 downto 0))) * to_integer(signed(rs2(15 downto 0)));
				signed_sum := signed_product + to_integer(signed(rs1(31 downto 0)));
				if signed_sum < 0 and (rs1(31) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(31 downto 0) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum > 0 and (rs1(31) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(31 downto 0) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 0) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
			
			-- Signed Integer Multiply-Add High with Saturation --
			-- Multiply high 16-bits of rs3 and rs2 (each 32-bit field) then add 32-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "001" then
				-- Pack 3 --
				signed_product := to_integer(signed(rs3(127 downto 112))) * to_integer(signed(rs2(127 downto 112)));
				signed_sum := signed_product + to_integer(signed(rs1(127 downto 96)));
				if signed_sum < 0 and (rs1(127) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(127 downto 96) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum > 0 and (rs1(127) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(127 downto 96) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 96) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;	
				
				-- Pack 2 --
				signed_product := to_integer(signed(rs3(95 downto 80))) * to_integer(signed(rs2(95 downto 80)));
				signed_sum := signed_product + to_integer(signed(rs1(95 downto 64)));
				if signed_sum < 0 and (rs1(95) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(95 downto 64) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum > 0 and (rs1(95) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(95 downto 64) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 64) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 1 --
				signed_product := to_integer(signed(rs3(63 downto 48))) * to_integer(signed(rs2(63 downto 48)));
				signed_sum := signed_product + to_integer(signed(rs1(63 downto 32)));
				if signed_sum < 0 and (rs1(63) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(63 downto 32) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum > 0 and (rs1(63) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(63 downto 32) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 32) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 0 --
				signed_product := to_integer(signed(rs3(31 downto 16))) * to_integer(signed(rs2(31 downto 16)));
				signed_sum := signed_product + to_integer(signed(rs1(31 downto 0)));
				if signed_sum < 0 and (rs1(31) = '0' and signed_product > 0) then
					-- overflow detected
					data_out(31 downto 0) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum > 0 and (rs1(31) = '1' and signed_product < 0) then
					-- underflow detected
					data_out(31 downto 0) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 0) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
			
			-- Signed Integer Multiply-Subtract Low with Saturation --
			-- Multiply low 16-bits of rs3 and rs2 (each 32-bit field) then subtract from 32-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "010" then
				-- Pack 3 --
				signed_product := to_integer(signed(rs3(111 downto 96))) * to_integer(signed(rs2(111 downto 96)));
				signed_sum := to_integer(signed(rs1(127 downto 96))) - signed_product;
				if signed_sum < 0 and (rs1(127) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(127 downto 96) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum > 0 and (rs1(127) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(127 downto 96) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 96) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 2 --
				signed_product := to_integer(signed(rs3(79 downto 64))) * to_integer(signed(rs2(79 downto 64)));
				signed_sum := to_integer(signed(rs1(95 downto 64))) - signed_product;
				if signed_sum < 0 and (rs1(95) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(95 downto 64) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum > 0 and (rs1(95) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(95 downto 64) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 64) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 1 --
				signed_product := to_integer(signed(rs3(47 downto 32))) * to_integer(signed(rs2(47 downto 32)));
				signed_sum := to_integer(signed(rs1(63 downto 32))) - signed_product;
				if signed_sum < 0 and (rs1(63) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(63 downto 32) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum > 0 and (rs1(63) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(63 downto 32) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 32) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 0 --
				signed_product := to_integer(signed(rs3(15 downto 0))) * to_integer(signed(rs2(15 downto 0)));
				signed_sum := to_integer(signed(rs1(31 downto 0))) - signed_product;
				if signed_sum < 0 and (rs1(31) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(31 downto 0) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum > 0 and (rs1(31) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(31 downto 0) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 0) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
			
			-- Signed Integer Multiply-Subtract High with Saturation --
			-- Multiply high 16-bits of rs3 and rs2 (each 32-bit field) then subtract from 32-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "011" then
				-- Pack 3 --
				signed_product := to_integer(signed(rs3(127 downto 112))) * to_integer(signed(rs2(127 downto 112)));
				signed_sum := to_integer(signed(rs1(127 downto 96))) - signed_product;
				if signed_sum < 0 and (rs1(127) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(127 downto 96) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum > 0 and (rs1(127) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(127 downto 96) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 96) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 2 --
				signed_product := to_integer(signed(rs3(95 downto 80))) * to_integer(signed(rs2(95 downto 80)));
				signed_sum := to_integer(signed(rs1(95 downto 64))) - signed_product;
				if signed_sum < 0 and (rs1(95) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(95 downto 64) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum > 0 and (rs1(95) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(95 downto 64) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 64) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 1 --
				signed_product := to_integer(signed(rs3(63 downto 48))) * to_integer(signed(rs2(63 downto 48)));
				signed_sum := to_integer(signed(rs1(63 downto 32))) - signed_product;
				if signed_sum < 0 and (rs1(63) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(63 downto 32) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum > 0 and (rs1(63) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(63 downto 32) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 32) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
				
				-- Pack 0 --
				signed_product := to_integer(signed(rs3(31 downto 16))) * to_integer(signed(rs2(31 downto 16)));
				signed_sum := to_integer(signed(rs1(31 downto 0))) - signed_product;
				if signed_sum < 0 and (rs1(31) = '0' and signed_product < 0) then
					-- overflow detected
					data_out(31 downto 0) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum > 0 and (rs1(31) = '1' and signed_product > 0) then
					-- underflow detected
					data_out(31 downto 0) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 0) <= std_logic_vector(to_signed(signed_sum, 32));
				end if;
			
			-- Signed Long Integer Multiply-Add Low with Saturation --
			-- Multiply low 32-bits of rs3 and rs2 (each 64-bit field) then add 64-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "100" then
				-- Pack 1 --
				product_sig := std_logic_vector(signed(rs3(95 downto 64)) * signed(rs2(95 downto 64)));
				sum_sig := std_logic_vector(signed(product_sig) + signed(rs1(127 downto 64)));
				if sum_sig(63) = '1' and (rs1(127) = '0' and product_sig(63) = '0') then
					-- overflow detected
					data_out(127 downto 64) <= (others => '1');
					data_out(127) <= '0';
				elsif sum_sig(63) = '0' and (rs1(127) = '1' and product_sig(63) = '1') then
					-- underflow detected
					data_out(127 downto 64) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 64) <= sum_sig;
				end if;
				
				-- Pack 0 --
				product_sig := std_logic_vector(signed(rs3(31 downto 0)) * signed(rs2(31 downto 0)));
				sum_sig := std_logic_vector(signed(product_sig) + signed(rs1(63 downto 0)));
				if sum_sig(63) = '1' and (rs1(63) = '0' and product_sig(63) = '0') then
					--overflow detected
					data_out(63 downto 0) <= (others => '1');
					data_out(63) <= '0';
				elsif sum_sig(63) = '0' and (rs1(63) = '1' and product_sig(63) = '1') then
					-- underflow detected
					data_out(63 downto 0) <= (others => '0');
					data_out(63) <= '1';
				else
					--data_out(63 downto 0) <= std_logic_vector(signed(sum_sig, 64)); 
					data_out(63 downto 0) <= sum_sig;
				end if;
			
			-- Signed Long Integer Multiply-Add High with Saturation --
			-- Multiply high 32-bits of rs3 and rs2 (each 64-bit field) then add 64-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "101" then
				-- Pack 1 --
				product_sig := std_logic_vector(signed(rs3(127 downto 96)) * signed(rs2(127 downto 96)));
				sum_sig := std_logic_vector(signed(product_sig) + signed(rs1(127 downto 64)));
				if sum_sig(63) = '1' and (rs1(127) = '0' and product_sig(63) = '0') then
					-- overflow detected
					data_out(127 downto 64) <= (others => '1');
					data_out(127) <= '0';
				elsif sum_sig(63) = '0' and (rs1(127) = '1' and product_sig(63) = '1') then
					-- underflow detected
					data_out(127 downto 64) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 64) <= sum_sig;
				end if;
				
				-- Pack 0 --
				product_sig := std_logic_vector(signed(rs3(63 downto 32)) * signed(rs2(63 downto 32)));
				sum_sig := std_logic_vector(signed(product_sig) + signed(rs1(63 downto 0)));
				if sum_sig(63) = '1' and (rs1(63) = '0' and product_sig(63) = '0') then
					-- overflow detected
					data_out(63 downto 0) <= (others => '1');
					data_out(63) <= '0';
				elsif sum_sig(63) = '0' and (rs1(63) = '1' and product_sig(63) = '1') then
					-- underflow detected
					data_out(63 downto 0) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 0) <= sum_sig;
				end if;
			
			-- Signed Long Integer Multiply-Subtract Low with Saturation --
			-- Multiply low 32-bits of rs3 and rs2 (each 64-bit field) then subtract from 64-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "110" then
				-- Pack 1 --
				product_sig := std_logic_vector(signed(rs3(95 downto 64)) * signed(rs2(95 downto 64)));
				sum_sig := std_logic_vector(signed(rs1(127 downto 64)) - signed(product_sig));
				if sum_sig(63) = '1' and (rs1(127) = '0' and product_sig(63) = '1') then
					-- overflow detected
					data_out(127 downto 64) <= (others => '1');
					data_out(127) <= '0';
				elsif sum_sig(63) = '0' and (rs1(127) = '1' and product_sig(63) = '0') then
					-- underflow detected
					data_out(127 downto 64) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 64) <= sum_sig;
				end if;
				
				-- Pack 0 --
				product_sig := std_logic_vector(signed(rs3(31 downto 0)) * signed(rs2(31 downto 0)));
				sum_sig := std_logic_vector(signed(rs1(63 downto 0)) - signed(product_sig));
				if sum_sig(63) = '1' and (rs1(63) = '0' and product_sig(63) = '1') then
					--overflow detected
					data_out(63 downto 0) <= (others => '1');
					data_out(63) <= '0';
				elsif sum_sig(63) = '0' and (rs1(63) = '1' and product_sig(63) = '0') then
					-- underflow detected
					data_out(63 downto 0) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 0) <= sum_sig;
				end if;
			
			-- Signed Long Integer Multiply-Subtract High with Saturation --
			-- Multiply high 32-bits of rs3 and rs2 (each 64-bit field) then subtract from 64-bits of rs1 with saturation --
			elsif R4_opcode(2 downto 0) = "111"  then
				-- Pack 1 --
				product_sig := std_logic_vector(signed(rs3(127 downto 96)) * signed(rs2(127 downto 96)));
				sum_sig := std_logic_vector(signed(rs1(127 downto 64)) - signed(product_sig));
				if sum_sig(63) = '1' and (rs1(127) = '0' and product_sig(63) = '1') then
					-- overflow detected
					data_out(127 downto 64) <= (others => '1');
					data_out(127) <= '0';
				elsif sum_sig(63) = '0' and (rs1(127) = '1' and product_sig(63) = '0') then
					-- underflow detected
					data_out(127 downto 64) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 64) <= sum_sig;
				end if;
				
				-- Pack 0 --
				product_sig := std_logic_vector(signed(rs3(63 downto 32)) * signed(rs2(63 downto 32)));
				sum_sig := std_logic_vector(signed(rs1(63 downto 0)) - signed(product_sig));
				if sum_sig(63) = '1' and (rs1(63) = '0' and product_sig(63) = '1') then
					-- overflow detected
					data_out(63 downto 0) <= (others => '1');
					data_out(63) <= '0';
				elsif sum_sig(63) = '0' and (rs1(63) = '1' and product_sig(63) = '0') then
					-- underflow detected
					data_out(63 downto 0) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 0) <= sum_sig;
				end if;
				
			end if; -- if R4 opcode
				
		end if; -- if R4 instr_type
	end process;

end behavioral;
