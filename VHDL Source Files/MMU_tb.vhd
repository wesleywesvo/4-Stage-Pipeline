-------------------------------------------------------------------------------
--
-- Title       : MMU_tb
-- Design      : Project
-- Author      : Wesley
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : D:\Aldec\My_Designs\ESE345\Project\src\MMU_tb.vhd
-- Generated   : Mon Apr 13 20:28:13 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the pipelined multimedia unit.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MMU_tb} architecture {MMU_tb}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.buff_arr.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity MMU_tb is
end MMU_tb;

architecture MMU_tb of MMU_tb is

signal clk_tb : std_logic;
signal instr_in_tb : instr_buff;

signal ID_rs1_data : std_logic_vector(127 downto 0);
signal ID_rs2_data : std_logic_vector(127 downto 0);
signal ID_rs3_data : std_logic_vector(127 downto 0);
signal ID_rd_data : std_logic_vector(127 downto 0);
signal EX_rs1_data : std_logic_vector(127 downto 0);
signal EX_rs2_data : std_logic_vector(127 downto 0);
signal EX_rs3_data : std_logic_vector(127 downto 0);
signal EX_rd_data : std_logic_vector(127 downto 0);

signal IF_Instruction_tb : std_logic_vector(24 downto 0);
signal ID_Instruction_tb : std_logic_vector(24 downto 0);
signal EX_Instruction_tb : std_logic_vector(24 downto 0);
signal WB_Instruction_tb : std_logic_vector(24 downto 0);
signal WB_data_tb : std_logic_vector(127 downto 0);
signal WB_rd_addr_tb : std_logic_vector(4 downto 0);
signal WB_wr_enable_tb : std_logic;

constant period : time := 20ns;
file file_input : text;
file file_output: text;

file register_values : text;
file expected_values : text;

begin
	UUT : entity work.MMU(structural) port map (
		instruction_input => instr_in_tb, 
		clk => clk_tb,
		
		ID_rs1_data => ID_rs1_data,
		ID_rs2_data => ID_rs2_data,
		ID_rs3_data => ID_rs3_data,
		ID_rd_data => ID_rd_data,
		EX_rs1_data => EX_rs1_data,
		EX_rs2_data => EX_rs2_data,
		EX_rs3_data => EX_rs3_data,
		EX_rd_data => EX_rd_data,
		
		IF_Instruction => IF_Instruction_tb,
		ID_Instruction => ID_Instruction_tb,
		EX_Instruction => EX_Instruction_tb,
		WB_Instruction => WB_Instruction_tb,
		WB_data => WB_data_tb,
		WB_rd_addr => WB_rd_addr_tb,
		WB_wr_enable => WB_wr_enable_tb
		);
	
	
	clock : process
	begin
		clk_tb <= '0';
	  	wait for 10ns;
	 	 clk_tb <= '1';
	  	wait for 10ns;
	end process;
	
	outputs : process
	
		variable line_v : line;
		variable outputline_v : line;
    	variable slv_v : std_logic_vector(24 downto 0);
    	variable count: integer := 0;
		variable v_out : line;
	
	begin
		file_open(file_input, "instr_binary.txt",  read_mode);
		file_open(file_output, "output.txt", write_mode); 
		file_open(register_values, "register_output.txt", write_mode);
		
		while not endfile(file_input) loop
			readline(file_input, line_v);
      		read(line_v, slv_v);   
	  		instr_in_tb(count)<= slv_v;
	  		count := count + 1;
    	end loop; 
    	file_close(file_input);
		
		for i in 0 to count + 4 loop
			wait for period;
			
			write(outputline_v, "Cycle " & to_string(i));
			writeline(file_output, outputline_v);
			write(outputline_v, "Stage 1: Instruction Fetch");
			writeline(file_output, outputline_v);
			write(outputline_v, "instruction:        " & to_string(IF_Instruction_tb));
			writeline(file_output, outputline_v);
			write(outputline_v, "===================");
			writeline(file_output, outputline_v);
			
			write(outputline_v, "Stage 2: Decode & Read Operands");
			writeline(file_output, outputline_v);
			write(outputline_v, "instruction:        " & to_string(ID_Instruction_tb));
			writeline(file_output, outputline_v);
				if ID_Instruction_tb(24 downto 23) = "00" or ID_Instruction_tb(24 downto 23) = "01" then
					write(outputline_v, "instruction type:   Load Immediate");
					writeline(file_output, outputline_v);
					write(outputline_v, "load index:         " & to_string(ID_Instruction_tb(23 downto 21)));
					writeline(file_output, outputline_v);
					write(outputline_v, "16-bit immediate:   " & to_string(ID_Instruction_tb(20 downto 5)));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(4 downto 0)))) & "]):    " & to_string(ID_rd_data));
					writeline(file_output, outputline_v);
					
				elsif ID_Instruction_tb(24 downto 23) = "10" then
					write(outputline_v, "instruction type:   R4");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             " & to_string(ID_Instruction_tb(22 downto 20)));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs3(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(19 downto 15)))) & "]):   " & to_string(ID_rs3_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs2(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(14 downto 10)))) & "]):   " & to_string(ID_rs2_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs1(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(9 downto 5)))) & "]):   " & to_string(ID_rs1_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(4 downto 0)))) & "]):    " & to_string(ID_rd_data));
					writeline(file_output, outputline_v);
					
				elsif ID_Instruction_tb(24 downto 23) = "11" then
					write(outputline_v, "instruction type:   R3");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             XXX" & to_string(ID_Instruction_tb(19 downto 15)));
						if ID_Instruction_tb(19 downto 15) = "00000" then
							write(outputline_v, " (NOP)");
						elsif ID_Instruction_tb(19 downto 15) = "00001" then
							write(outputline_v, " (A)");
						elsif ID_Instruction_tb(19 downto 15) = "00010" then
							write(outputline_v, " (AH)");
						elsif ID_Instruction_tb(19 downto 15) = "00011" then
							write(outputline_v, " (AHS)");
						elsif ID_Instruction_tb(19 downto 15) = "00100" then
							write(outputline_v, " (AND)");
						elsif ID_Instruction_tb(19 downto 15) = "00101" then
							write(outputline_v, " (BCW)");
						elsif ID_Instruction_tb(19 downto 15) = "00110" then
							write(outputline_v, " (CLZ)");
						elsif ID_Instruction_tb(19 downto 15) = "00111" then
							write(outputline_v, " (ABSDB)");
						elsif ID_Instruction_tb(19 downto 15) = "01001" then
							write(outputline_v, " (MSGN)");
						elsif ID_Instruction_tb(19 downto 15) = "01010" then
							write(outputline_v, " (MPYU)");
						elsif ID_Instruction_tb(19 downto 15) = "01011" then
							write(outputline_v, " (OR)");
						elsif ID_Instruction_tb(19 downto 15) = "01100" then
							write(outputline_v, " (POPCNTW)");
						elsif ID_Instruction_tb(19 downto 15) = "01101" then
							write(outputline_v, " (ROT)");
						elsif ID_Instruction_tb(19 downto 15) = "01110" then
							write(outputline_v, " (ROTW)");
						elsif ID_Instruction_tb(19 downto 15) = "01111" then
							write(outputline_v, " (SHLHI)");
						elsif ID_Instruction_tb(19 downto 15) = "10000" then
							write(outputline_v, " (SFH)");
						elsif ID_Instruction_tb(19 downto 15) = "10001" then
							write(outputline_v, " (SFW)");
						elsif ID_Instruction_tb(19 downto 15) = "10010" then
							write(outputline_v, " (SFHS)");
						elsif ID_Instruction_tb(19 downto 15) = "10011" then
							write(outputline_v, " (NAND)");
						end if;
					writeline(file_output, outputline_v);
					write(outputline_v, "rs2(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(14 downto 10)))) & "]):   " & to_string(ID_rs2_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs1(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(9 downto 5)))) & "]):   " & to_string(ID_rs1_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(ID_Instruction_tb(4 downto 0)))) & "]):    " & to_string(ID_rd_data));
					writeline(file_output, outputline_v);
				end if;
			write(outputline_v, "===================");
			writeline(file_output, outputline_v);
			
			write(outputline_v, "Stage 3: Execute");
			writeline(file_output, outputline_v);
			write(outputline_v, "instruction:        " & to_string(EX_Instruction_tb));
			writeline(file_output, outputline_v);
				if EX_Instruction_tb(24 downto 23) = "00" or EX_Instruction_tb(24 downto 23) = "01" then
					write(outputline_v, "instruction type:   Load Immediate");
					writeline(file_output, outputline_v);
					write(outputline_v, "load index:         " & to_string(EX_Instruction_tb(23 downto 21)));
					writeline(file_output, outputline_v);
					write(outputline_v, "16-bit immediate:   " & to_string(EX_Instruction_tb(20 downto 5)));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(4 downto 0)))) & "]):    " & to_string(EX_rd_data));
					writeline(file_output, outputline_v);
					
				elsif EX_Instruction_tb(24 downto 23) = "10" then
					write(outputline_v, "instruction type:   R4");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             " & to_string(EX_Instruction_tb(22 downto 20)));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs3(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(19 downto 15)))) & "]):   " & to_string(EX_rs3_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs2(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(14 downto 10)))) & "]):   " & to_string(EX_rs2_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs1(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(9 downto 5)))) & "]):   " & to_string(EX_rs1_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(4 downto 0)))) & "]):    " & to_string(EX_rd_data));
					writeline(file_output, outputline_v);
					
				elsif EX_Instruction_tb(24 downto 23) = "11" then
					write(outputline_v, "instruction type:   R3");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             XXX" & to_string(EX_Instruction_tb(19 downto 15)));
						if EX_Instruction_tb(19 downto 15) = "00000" then
							write(outputline_v, " (NOP)");
						elsif EX_Instruction_tb(19 downto 15) = "00001" then
							write(outputline_v, " (A)");
						elsif EX_Instruction_tb(19 downto 15) = "00010" then
							write(outputline_v, " (AH)");
						elsif EX_Instruction_tb(19 downto 15) = "00011" then
							write(outputline_v, " (AHS)");
						elsif EX_Instruction_tb(19 downto 15) = "00100" then
							write(outputline_v, " (AND)");
						elsif EX_Instruction_tb(19 downto 15) = "00101" then
							write(outputline_v, " (BCW)");
						elsif EX_Instruction_tb(19 downto 15) = "00110" then
							write(outputline_v, " (CLZ)");
						elsif EX_Instruction_tb(19 downto 15) = "00111" then
							write(outputline_v, " (ABSDB)");
						elsif EX_Instruction_tb(19 downto 15) = "01001" then
							write(outputline_v, " (MSGN)");
						elsif EX_Instruction_tb(19 downto 15) = "01010" then
							write(outputline_v, " (MPYU)");
						elsif EX_Instruction_tb(19 downto 15) = "01011" then
							write(outputline_v, " (OR)");
						elsif EX_Instruction_tb(19 downto 15) = "01100" then
							write(outputline_v, " (POPCNTW)");
						elsif EX_Instruction_tb(19 downto 15) = "01101" then
							write(outputline_v, " (ROT)");
						elsif EX_Instruction_tb(19 downto 15) = "01110" then
							write(outputline_v, " (ROTW)");
						elsif EX_Instruction_tb(19 downto 15) = "01111" then
							write(outputline_v, " (SHLHI)");
						elsif EX_Instruction_tb(19 downto 15) = "10000" then
							write(outputline_v, " (SFH)");
						elsif EX_Instruction_tb(19 downto 15) = "10001" then
							write(outputline_v, " (SFW)");
						elsif EX_Instruction_tb(19 downto 15) = "10010" then
							write(outputline_v, " (SFHS)");
						elsif EX_Instruction_tb(19 downto 15) = "10011" then
							write(outputline_v, " (NAND)");
						end if;
					writeline(file_output, outputline_v);
					write(outputline_v, "rs2(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(14 downto 10)))) & "]):   " & to_string(EX_rs2_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rs1(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(9 downto 5)))) & "]):   " & to_string(EX_rs1_data));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd(Register[" & to_string(to_integer(unsigned(EX_Instruction_tb(4 downto 0)))) & "]):    " & to_string(EX_rd_data));
					writeline(file_output, outputline_v);
				end if;
			write(outputline_v, "===================");
			writeline(file_output, outputline_v);
			
			write(outputline_v, "Stage 4: Write Back");
			writeline(file_output, outputline_v);
			write(outputline_v, "instruction:        " & to_string(WB_Instruction_tb));
			writeline(file_output, outputline_v);
				if WB_Instruction_tb(24 downto 23) = "00" or WB_Instruction_tb(24 downto 23) = "01" then
					write(outputline_v, "instruction type:   Load Immediate");
					writeline(file_output, outputline_v);
					write(outputline_v, "load index:         " & to_string(WB_Instruction_tb(23 downto 21)));
					writeline(file_output, outputline_v);
					write(outputline_v, "16-bit immediate:   " & to_string(WB_Instruction_tb(20 downto 5)));
					writeline(file_output, outputline_v);
					
				elsif WB_Instruction_tb(24 downto 23) = "10" then
					write(outputline_v, "instruction type:   R4");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             " & to_string(WB_Instruction_tb(22 downto 20)));
					writeline(file_output, outputline_v);
					write(outputline_v, "rd address:         " & to_string(WB_Instruction_tb(4 downto 0)));
					writeline(file_output, outputline_v);
					
				elsif WB_Instruction_tb(24 downto 23) = "11" then
					write(outputline_v, "instruction type:   R3");
					writeline(file_output, outputline_v);
					write(outputline_v, "opcode:             XXX" & to_string(WB_Instruction_tb(19 downto 15)));
						if WB_Instruction_tb(19 downto 15) = "00000" then
							write(outputline_v, " (NOP)");
						elsif WB_Instruction_tb(19 downto 15) = "00001" then
							write(outputline_v, " (A)");
						elsif WB_Instruction_tb(19 downto 15) = "00010" then
							write(outputline_v, " (AH)");
						elsif WB_Instruction_tb(19 downto 15) = "00011" then
							write(outputline_v, " (AHS)");
						elsif WB_Instruction_tb(19 downto 15) = "00100" then
							write(outputline_v, " (AND)");
						elsif WB_Instruction_tb(19 downto 15) = "00101" then
							write(outputline_v, " (BCW)");
						elsif WB_Instruction_tb(19 downto 15) = "00110" then
							write(outputline_v, " (CLZ)");
						elsif WB_Instruction_tb(19 downto 15) = "00111" then
							write(outputline_v, " (ABSDB)");
						elsif WB_Instruction_tb(19 downto 15) = "01001" then
							write(outputline_v, " (MSGN)");
						elsif WB_Instruction_tb(19 downto 15) = "01010" then
							write(outputline_v, " (MPYU)");
						elsif WB_Instruction_tb(19 downto 15) = "01011" then
							write(outputline_v, " (OR)");
						elsif WB_Instruction_tb(19 downto 15) = "01100" then
							write(outputline_v, " (POPCNTW)");
						elsif WB_Instruction_tb(19 downto 15) = "01101" then
							write(outputline_v, " (ROT)");
						elsif WB_Instruction_tb(19 downto 15) = "01110" then
							write(outputline_v, " (ROTW)");
						elsif WB_Instruction_tb(19 downto 15) = "01111" then
							write(outputline_v, " (SHLHI)");
						elsif WB_Instruction_tb(19 downto 15) = "10000" then
							write(outputline_v, " (SFH)");
						elsif WB_Instruction_tb(19 downto 15) = "10001" then
							write(outputline_v, " (SFW)");
						elsif WB_Instruction_tb(19 downto 15) = "10010" then
							write(outputline_v, " (SFHS)");
						elsif WB_Instruction_tb(19 downto 15) = "10011" then
							write(outputline_v, " (NAND)");
						end if;
					writeline(file_output, outputline_v);
					write(outputline_v, "rd address:         " & to_string(WB_Instruction_tb(4 downto 0)));
					writeline(file_output, outputline_v);
					
				end if;
			write(outputline_v, "write enable:       " & to_string(WB_wr_enable_tb));
			writeline(file_output, outputline_v);
				if WB_wr_enable_tb = '1' then
					write(outputline_v, "data to write:      " & to_string(WB_data_tb(127 downto 0)));
					writeline(file_output, outputline_v);
					write(outputline_v, "write-back address: " & to_string(WB_rd_addr_tb(4 downto 0)));
					writeline(file_output, outputline_v);
					writeline(file_output, outputline_v);
					
					-- writing results to a separate file
					write(outputline_v, "R" & to_string(to_integer(unsigned(WB_rd_addr_tb(4 downto 0)))) & ": " & to_hex_string(WB_data_tb(127 downto 0)));
					writeline(register_values, outputline_v);
				else
					writeline(file_output, outputline_v);
				end if;
	
	   end loop;
	   file_close(file_output);
	   file_close(file_input);
	   
	  /* -- compare register_values to expected_outputs
	   file_open(register_values, "register_output.txt",  read_mode);
	   file_open(expected_values, "expected.txt",  read_mode);
	   
	   while not endfile(register_values) loop
			readline(register_values, line_v);
      		read(line_v, val);
			  
			readline(expected_values, line_v);
			read(line_v, expected);	
			
			if val = expected then
				assert report "Good";
			else
				assert report "Bad";
			end if;
	  		
    	end loop; 
    	file_close(register_values);
		file_close(expected_values);
	   	 */
	   wait;
	   end process;

end MMU_tb;
