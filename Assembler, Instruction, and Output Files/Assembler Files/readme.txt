INSTRUCTION FORMAT:

LOAD: ldi rd, immediate(index)            ie: ldi r1, 7FFE(0)

R4 FORMAT: LI/SA/HL rd, rs1, rs2, rs3     ie: 000 r17, r3, r13, r13  (000 = signed integer multiply-add low with saturation)

R3 FORMAT: op rd, rs1, rs2           ie: a r5, r1, r4  (a = add word)

DUPLICATE MPYU INSTR: dupe rd (rd = rs1 = rs2)       
ie: dupe r8 (this will encode the MPYU opcode xxx01000 in binary with the register r8 in all fields - this was to test for the write signal)


Input file name: instruction_text.txt
Output file name: instr_binary.txt