-------------------------------------------------------------------------------
--
-- Title       : R3_Type_Instr
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : d:\Aldec\My_Designs\ESE345\Project\src\R3_Type_Instr.vhd
-- Generated   : Mon Mar 30 15:24:51 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Reads the values from the ID/EX Register unit to determine if
--  the instruction is "R3-format". Performs appropriate operations if
--  applicable and outputs the value.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {R3_Type_Instr} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity R3_Type_Instr is
	 port(
		 instr_type : in STD_LOGIC_VECTOR(1 downto 0);
		 R3_opcode : in STD_LOGIC_VECTOR(7 downto 0);
		 rs1 : in STD_LOGIC_VECTOR(127 downto 0);
		 rs2 : in STD_LOGIC_VECTOR(127 downto 0);
		 
		 data_out : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end R3_Type_Instr;

architecture behavioral of R3_Type_Instr is
begin

	process (instr_type, R3_opcode, rs1, rs2)
	
		constant MAX_WORD_SIGNED : integer := 2147483647;
		constant MIN_WORD_SIGNED : integer := -2147483648;
		constant MAX_HALFWORD_SIGNED : integer := 32767;
		constant MIN_HALFWORD_SIGNED : integer := -32768;
	
		variable counter : integer range 0 to 32; -- CLZ/POPCNTW
		variable signed_sum : integer; -- AHS/SFHS
		variable signed_product : integer; -- MSGN
	
	begin
		-- R3 Instruction type --
		if instr_type = "11" then
			-- NOP --
			if R3_opcode(4 downto 0) = "00000" then
				null;  
				
			-- Add Word "A" --
			elsif R3_opcode(4 downto 0) = "00001" then
				data_out(127 downto 96) <= std_logic_vector(unsigned(rs1(127 downto 96)) + unsigned(rs2(127 downto 96)));
				data_out(95 downto 64) <= std_logic_vector(unsigned(rs1(95 downto 64)) + unsigned(rs2(95 downto 64)));
				data_out(63 downto 32) <= std_logic_vector(unsigned(rs1(63 downto 32)) + unsigned(rs2(63 downto 32)));
				data_out(31 downto 0) <= std_logic_vector(unsigned(rs1(31 downto 0)) + unsigned(rs2(31 downto 0)));
				
			-- Add Halfword "AH" --
			elsif R3_opcode(4 downto 0) = "00010" then
				data_out(127 downto 112) <= std_logic_vector(unsigned(rs1(127 downto 112)) + unsigned(rs2(127 downto 112)));
				data_out(111 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) + unsigned(rs2(111 downto 96)));
				data_out(95 downto 80) <= std_logic_vector(unsigned(rs1(95 downto 80)) + unsigned(rs2(95 downto 80)));
				data_out(79 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) + unsigned(rs2(79 downto 64)));
				data_out(63 downto 48) <= std_logic_vector(unsigned(rs1(63 downto 48)) + unsigned(rs2(63 downto 48)));
				data_out(47 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) + unsigned(rs2(47 downto 32)));
				data_out(31 downto 16) <= std_logic_vector(unsigned(rs1(31 downto 16)) + unsigned(rs2(31 downto 16)));
				data_out(15 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) + unsigned(rs2(15 downto 0)));
			
			-- Add Halfword Saturated "AHS" --
			elsif R3_opcode(4 downto 0) = "00011" then
				-- Pack 7 --
				signed_sum := to_integer(signed(rs1(127 downto 112))) + to_integer(signed(rs2(127 downto 112)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(127 downto 112) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(127 downto 112) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 112) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 6 --
				signed_sum := to_integer(signed(rs1(111 downto 96))) + to_integer(signed(rs2(111 downto 96)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(111 downto 96) <= (others => '1');
					data_out(111) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(111 downto 96) <= (others => '0');
					data_out(111) <= '1';
				else
					data_out(111 downto 96) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 5 --
				signed_sum := to_integer(signed(rs1(95 downto 80))) + to_integer(signed(rs2(95 downto 80)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(95 downto 80) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(95 downto 80) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 80) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 4 --
				signed_sum := to_integer(signed(rs1(79 downto 64))) + to_integer(signed(rs2(79 downto 64)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(79 downto 64) <= (others => '1');
					data_out(79) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(79 downto 64) <= (others => '0');
					data_out(79) <= '1';
				else
					data_out(79 downto 64) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 3 --
				signed_sum := to_integer(signed(rs1(63 downto 48))) + to_integer(signed(rs2(63 downto 48)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(63 downto 48) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(63 downto 48) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 48) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 2 --
				signed_sum := to_integer(signed(rs1(47 downto 32))) + to_integer(signed(rs2(47 downto 32)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(47 downto 32) <= (others => '1');
					data_out(47) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(47 downto 32) <= (others => '0');
					data_out(47) <= '1';
				else
					data_out(47 downto 32) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 1 --
				signed_sum := to_integer(signed(rs1(31 downto 16))) + to_integer(signed(rs2(31 downto 16)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(31 downto 16) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(31 downto 16) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 16) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 0 --
				signed_sum := to_integer(signed(rs1(15 downto 0))) + to_integer(signed(rs2(15 downto 0)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(15 downto 0) <= (others => '1');
					data_out(15) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(15 downto 0) <= (others => '0');
					data_out(15) <= '1';
				else
					data_out(15 downto 0) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
			
			-- Bitwise Logical AND "AND" --
			elsif R3_opcode(4 downto 0) = "00100" then
				data_out <= rs1 and rs2;
			
			-- Broadcast Word "BCW" --
			elsif R3_opcode(4 downto 0) = "00101" then
				data_out(127 downto 96) <= rs1(31 downto 0);
				data_out(95 downto 64) <= rs1(31 downto 0);
				data_out(63 downto 32) <= rs1(31 downto 0);
				data_out(31 downto 0) <= rs1(31 downto 0);
			
			-- Count Leading Zeros in Words "CLZ" --
			elsif R3_opcode(4 downto 0) = "00110" then 
				-- Pack 3 --
				counter := 0;
				for i in 127 downto 96 loop
					if rs1(i) = '0' then
						counter := counter + 1;
					else
						exit;
					end if;
				end loop;
				data_out(127 downto 96) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 2 --
				counter := 0;
				for i in 95 downto 64 loop
					if rs1(i) = '0' then
						counter := counter + 1;
					else
						exit;
					end if;
				end loop;
				data_out(95 downto 64) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 1 --
				counter := 0;
				for i in 63 downto 32 loop
					if rs1(i) = '0' then
						counter := counter + 1;
					else
						exit;
					end if;
				end loop;
				data_out(63 downto 32) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 0 --
				counter := 0;
				for i in 31 downto 0 loop
					if rs1(i) = '0' then
						counter := counter + 1;
					else
						exit;
					end if;
				end loop;
				data_out(31 downto 0) <= std_logic_vector(to_unsigned(counter, 32));
			
			-- Absolute Difference of Bytes "ABSDB" --
			elsif R3_opcode(4 downto 0) = "00111" then
				data_out(127 downto 112) <= std_logic_vector(abs(signed(rs1(127 downto 112)) - signed(rs2(127 downto 112))));
				data_out(111 downto 96) <= std_logic_vector(abs(signed(rs1(111 downto 96)) - signed(rs2(111 downto 96))));
				data_out(95 downto 80) <= std_logic_vector(abs(signed(rs1(95 downto 80)) - signed(rs2(95 downto 80))));
				data_out(79 downto 64) <= std_logic_vector(abs(signed(rs1(79 downto 64)) - signed(rs2(79 downto 64))));
				data_out(63 downto 48) <= std_logic_vector(abs(signed(rs1(63 downto 48)) - signed(rs2(63 downto 48))));
				data_out(47 downto 32) <= std_logic_vector(abs(signed(rs1(47 downto 32)) - signed(rs2(47 downto 32))));
				data_out(31 downto 16) <= std_logic_vector(abs(signed(rs1(31 downto 16)) - signed(rs2(31 downto 16))));
				data_out(15 downto 0) <= std_logic_vector(abs(signed(rs1(15 downto 0)) - signed(rs2(15 downto 0))));
			
			-- Multiply Signed "MSGN" --
			-- with saturation --
			elsif R3_opcode(4 downto 0) = "01001" then 
				-- Pack 3 --
				signed_product := to_integer(signed(rs1(127 downto 96))) * to_integer(signed(rs2(127 downto 96)));
				
				if signed_product = 0 then
					null;
				elsif signed_product / to_integer(signed(rs1(127 downto 96))) /= to_integer(signed(rs2(127 downto 96))) 
					or signed_product / to_integer(signed(rs2(127 downto 96))) /= to_integer(signed(rs1(127 downto 96))) then
					if (rs1(127) xnor rs2(127)) = '1' then
						signed_product := MAX_WORD_SIGNED;
					elsif (rs1(127) xor rs2(127)) = '1' then
						signed_product := MIN_WORD_SIGNED;
					end if;
				end if;
				data_out(127 downto 96) <= std_logic_vector(to_signed(signed_product, 32));
				
				-- Pack 2 --
				signed_product := to_integer(signed(rs1(95 downto 64))) * to_integer(signed(rs2(95 downto 64)));
				
				if signed_product = 0 then
					null;
				elsif signed_product / to_integer(signed(rs1(95 downto 64))) /= to_integer(signed(rs2(95 downto 64))) 
					or signed_product / to_integer(signed(rs2(95 downto 64))) /= to_integer(signed(rs1(95 downto 64))) then
					if (rs1(95) xnor rs2(95)) = '1' then
						signed_product := MAX_WORD_SIGNED;
					elsif (rs1(95) xor rs2(95)) = '1' then
						signed_product := MIN_WORD_SIGNED;
					end if;
				end if;
				data_out(95 downto 64) <= std_logic_vector(to_signed(signed_product, 32));
				
				-- Pack 1 --
				signed_product := to_integer(signed(rs1(63 downto 32))) * to_integer(signed(rs2(63 downto 32)));
				
				if signed_product = 0 then
					null;
				elsif signed_product / to_integer(signed(rs1(63 downto 32))) /= to_integer(signed(rs2(63 downto 32))) 
					or signed_product / to_integer(signed(rs2(63 downto 32))) /= to_integer(signed(rs1(63 downto 32))) then
					if (rs1(63) xnor rs2(63)) = '1' then
						signed_product := MAX_WORD_SIGNED;
					elsif (rs1(63) xor rs2(63)) = '1' then
						signed_product := MIN_WORD_SIGNED;
					end if;
				end if;
				data_out(63 downto 32) <= std_logic_vector(to_signed(signed_product, 32));
				
				-- Pack 0 --
				signed_product := to_integer(signed(rs1(31 downto 0))) * to_integer(signed(rs2(31 downto 0))); 
				
				if signed_product = 0 then
					null;
				elsif signed_product / to_integer(signed(rs1(31 downto 0))) /= to_integer(signed(rs2(31 downto 0))) 
					or signed_product / to_integer(signed(rs2(31 downto 0))) /= to_integer(signed(rs1(31 downto 0))) then
					if (rs1(31) xnor rs2(31)) = '1' then
						signed_product := MAX_WORD_SIGNED;
					elsif (rs1(31) xor rs2(31)) = '1' then
						signed_product := MIN_WORD_SIGNED;
					end if;
				end if;
				data_out(31 downto 0) <= std_logic_vector(to_signed(signed_product, 32));
			
			-- Multiply Unsigned "MPYU" --
			elsif R3_opcode(4 downto 0) = "01010" then
				data_out(127 downto 96) <= std_logic_vector(unsigned(rs1(111 downto 96)) * unsigned(rs2(111 downto 96)));
				data_out(95 downto 64) <= std_logic_vector(unsigned(rs1(79 downto 64)) * unsigned(rs2(79 downto 64)));
				data_out(63 downto 32) <= std_logic_vector(unsigned(rs1(47 downto 32)) * unsigned(rs2(47 downto 32)));
				data_out(31 downto 0) <= std_logic_vector(unsigned(rs1(15 downto 0)) * unsigned(rs2(15 downto 0)));
			
			-- Bitwise Logical OR "OR" --
			elsif R3_opcode(4 downto 0) = "01011" then
				data_out <= rs1 or rs2;
			
			-- Count Ones in Words "POPCNTW" --
			elsif R3_opcode(4 downto 0) = "01100" then
				-- Pack 3 --
				counter := 0;
				for i in 127 downto 96 loop
					if rs1(i) = '1' then
						counter := counter + 1;
					end if;
				end loop;
				data_out(127 downto 96) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 2 --
				counter := 0;
				for i in 95 downto 64 loop
					if rs1(i) = '1' then
						counter := counter + 1;
					end if;
				end loop;
				data_out(95 downto 64) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 1 --
				counter := 0;
				for i in 63 downto 32 loop
					if rs1(i) = '1' then
						counter := counter + 1;
					end if;
				end loop;
				data_out(63 downto 32) <= std_logic_vector(to_unsigned(counter, 32));
				
				-- Pack 0 --
				counter := 0;
				for i in 31 downto 0 loop
					if rs1(i) = '1' then
						counter := counter + 1;
					end if;
				end loop;
				data_out(31 downto 0) <= std_logic_vector(to_unsigned(counter, 32));
			
			-- Rotate Bits Right "ROT" --
			elsif R3_opcode(4 downto 0) = "01101" then
				data_out <= std_logic_vector(rotate_right(unsigned(rs1), to_integer(unsigned(rs2(6 downto 0)))));
			
			-- Rotate Bits in Word "ROTW" --
			elsif R3_opcode(4 downto 0) = "01110" then
				data_out(127 downto 96) <= std_logic_vector(rotate_right(unsigned(rs1(127 downto 96)), to_integer(unsigned(rs2(100 downto 96)))));
				data_out(95 downto 64) <= std_logic_vector(rotate_right(unsigned(rs1(95 downto 64)), to_integer(unsigned(rs2(70 downto 64)))));
				data_out(63 downto 32) <= std_logic_vector(rotate_right(unsigned(rs1(63 downto 32)), to_integer(unsigned(rs2(36 downto 32)))));
				data_out(31 downto 0) <= std_logic_vector(rotate_right(unsigned(rs1(31 downto 0)), to_integer(unsigned(rs2(4 downto 0)))));
			
			-- Shift Left Halfword Immediate "SHLHI" --
			elsif R3_opcode(4 downto 0) = "01111" then
				data_out(127 downto 112) <= rs1(127 downto 112) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(111 downto 96) <= rs1(111 downto 96) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(95 downto 80) <= rs1(95 downto 80) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(79 downto 64) <= rs1(79 downto 64) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(63 downto 48) <= rs1(63 downto 48) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(47 downto 32) <= rs1(47 downto 32) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(31 downto 16) <= rs1(31 downto 16) sll to_integer(unsigned(rs2(3 downto 0)));
				data_out(15 downto 0) <= rs1(15 downto 0) sll to_integer(unsigned(rs2(3 downto 0)));
				
			-- Subtract from Halfword "SFH" --
			elsif R3_opcode(4 downto 0) = "10000" then
				data_out(127 downto 112) <= std_logic_vector(unsigned(rs2(127 downto 112)) - unsigned(rs1(127 downto 112)));
				data_out(111 downto 96) <= std_logic_vector(unsigned(rs2(111 downto 96)) - unsigned(rs1(111 downto 96)));
				data_out(95 downto 80) <= std_logic_vector(unsigned(rs2(95 downto 80)) - unsigned(rs1(95 downto 80)));
				data_out(79 downto 64) <= std_logic_vector(unsigned(rs2(79 downto 64)) - unsigned(rs1(79 downto 64)));
				data_out(63 downto 48) <= std_logic_vector(unsigned(rs2(63 downto 48)) - unsigned(rs1(63 downto 48)));
				data_out(47 downto 32) <= std_logic_vector(unsigned(rs2(47 downto 32)) - unsigned(rs1(47 downto 32)));
				data_out(31 downto 16) <= std_logic_vector(unsigned(rs2(31 downto 16)) - unsigned(rs1(31 downto 16)));
				data_out(15 downto 0) <= std_logic_vector(unsigned(rs2(15 downto 0)) - unsigned(rs1(15 downto 0)));
			
			-- Subtract from Word "SFW" --
			elsif R3_opcode(4 downto 0) = "10001" then
				data_out(127 downto 96) <= std_logic_vector(unsigned(rs2(127 downto 96)) - unsigned(rs1(127 downto 96)));
				data_out(95 downto 64) <= std_logic_vector(unsigned(rs2(95 downto 64)) - unsigned(rs1(95 downto 64)));
				data_out(63 downto 32) <= std_logic_vector(unsigned(rs2(63 downto 32)) - unsigned(rs1(63 downto 32)));
				data_out(31 downto 0) <= std_logic_vector(unsigned(rs2(31 downto 0)) - unsigned(rs1(31 downto 0)));
			
			-- Subtract from Halfword Saturated "SFHS" --
			elsif R3_opcode(4 downto 0) = "10010" then
				-- Pack 7 --
				signed_sum := to_integer(signed(rs2(127 downto 112))) - to_integer(signed(rs1(127 downto 112)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(127 downto 112) <= (others => '1');
					data_out(127) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(127 downto 112) <= (others => '0');
					data_out(127) <= '1';
				else
					data_out(127 downto 112) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 6 --
				signed_sum := to_integer(signed(rs2(111 downto 96))) - to_integer(signed(rs1(111 downto 96)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(111 downto 96) <= (others => '1');
					data_out(111) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(111 downto 96) <= (others => '0');
					data_out(111) <= '1';
				else
					data_out(111 downto 96) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 5 --
				signed_sum := to_integer(signed(rs2(95 downto 80))) - to_integer(signed(rs1(95 downto 80)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(95 downto 80) <= (others => '1');
					data_out(95) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(95 downto 80) <= (others => '0');
					data_out(95) <= '1';
				else
					data_out(95 downto 80) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 4 --
				signed_sum := to_integer(signed(rs2(79 downto 64))) - to_integer(signed(rs1(79 downto 64)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(79 downto 64) <= (others => '1');
					data_out(79) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(79 downto 64) <= (others => '0');
					data_out(79) <= '1';
				else
					data_out(79 downto 64) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 3 --
				signed_sum := to_integer(signed(rs2(63 downto 48))) - to_integer(signed(rs1(63 downto 48)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(63 downto 48) <= (others => '1');
					data_out(63) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(63 downto 48) <= (others => '0');
					data_out(63) <= '1';
				else
					data_out(63 downto 48) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 2 --
				signed_sum := to_integer(signed(rs2(47 downto 32))) - to_integer(signed(rs1(47 downto 32)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(47 downto 32) <= (others => '1');
					data_out(47) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(47 downto 32) <= (others => '0');
					data_out(47) <= '1';
				else
					data_out(47 downto 32) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 1 --
				signed_sum := to_integer(signed(rs2(31 downto 16))) - to_integer(signed(rs1(31 downto 16)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(31 downto 16) <= (others => '1');
					data_out(31) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(31 downto 16) <= (others => '0');
					data_out(31) <= '1';
				else
					data_out(31 downto 16) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
				
				-- Pack 0 --
				signed_sum := to_integer(signed(rs2(15 downto 0))) - to_integer(signed(rs1(15 downto 0)));
				if signed_sum > MAX_HALFWORD_SIGNED then
					data_out(15 downto 0) <= (others => '1');
					data_out(15) <= '0';
				elsif signed_sum < MIN_HALFWORD_SIGNED then
					data_out(15 downto 0) <= (others => '0');
					data_out(15) <= '1';
				else
					data_out(15 downto 0) <= std_logic_vector(to_signed(signed_sum, 16));
				end if;
			
			-- Bitwise Logical NAND "NAND" --
			elsif R3_opcode(4 downto 0) = "10011" then
				data_out <= rs1 nand rs2;
			
			---------------------------------
			else
				null;
			
			end if; -- if R3 opcode	
				
		end if; -- if R3 instr_type
	end process;

end behavioral;
