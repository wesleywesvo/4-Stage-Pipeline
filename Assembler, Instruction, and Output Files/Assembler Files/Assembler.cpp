//Assembler for ESE 345 Project
//Wesley Vo, Zachary Wong
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

string decToBinary(int dec, int n) {
	vector<int> bin;
	string bin_str = "";
	for (int i = 0; i < n; i++) { //n-bit number
		bin.push_back(dec % 2);
		dec = dec / 2;
	}
	reverse(bin.begin(), bin.end());
	for (int j = 0; j < n; j++) {
		bin_str += to_string(bin[j]);
	}
	return bin_str;
}

string hexToBinary(string hex) {
	int i = 0;
	string hex_str = "";
	while (hex[i]) {

		switch (hex[i]) {
		case '0':
			hex_str += "0000";
			break;
		case '1':
			hex_str += "0001";
			break;
		case '2':
			hex_str += "0010";
			break;
		case '3':
			hex_str += "0011";
			break;
		case '4':
			hex_str += "0100";
			break;
		case '5':
			hex_str += "0101";
			break;
		case '6':
			hex_str += "0110";
			break;
		case '7':
			hex_str += "0111";
			break;
		case '8':
			hex_str += "1000";
			break;
		case '9':
			hex_str += "1001";
			break;
		case 'A':
		case 'a':
			hex_str += "1010";
			break;
		case 'B':
		case 'b':
			hex_str += "1011";
			break;
		case 'C':
		case 'c':
			hex_str += "1100";
			break;
		case 'D':
		case 'd':
			hex_str += "1101";
			break;
		case 'E':
		case 'e':
			hex_str += "1110";
			break;
		case 'F':
		case 'f':
			hex_str += "1111";
			break;
		default:
			break;
		}
		i++;
	}
	return hex_str;
}

int main() {
	ifstream input;
	ofstream output;
	input.open("instruction_text.txt");
	output.open("instr_binary.txt");
	string str, temp, instr_code = "";
	while (getline(input, str)) {
		if (str.find("ldi") != string::npos) {
			string immed, ld_index, r_dest;
			int comma = str.find(",");  //comma position
			int index_start = str.find("(") + 1;
			int index_end = str.find(")");
			instr_code += "0";
			temp = str.substr(5, comma - 5);
			int rd = stoi(temp);
			r_dest = decToBinary(rd, 5);
			temp = str.substr(comma + 2, 4);
			immed = hexToBinary(temp);
			temp = str.substr(index_start, index_end - index_start);
			int index = stoi(temp);
			ld_index = decToBinary(index, 3);
			instr_code += (ld_index + immed + r_dest);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.substr(0, 2) == "a ") {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100000001";
			temp = str.substr(3, comma1 - 3);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.substr(0, 3) == "ah ") {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100000010";
			temp = str.substr(4, comma1 - 4);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("ahs") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000011";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.substr(0, 3) == "and") {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000100";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("bcw") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000101";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("clz") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000110";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("absdb") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000111";
			temp = str.substr(7, comma1 - 7);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("mpyu") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100001010";
			temp = str.substr(6, comma1 - 6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("dupe") != string::npos) { //instr for duplicate mpyu
			string rs2, rs1, rd;
			instr_code += "1100001000";
			temp = str.substr(6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			rs2 = rs1 = rd;
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("nop") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100000000000000000000000";
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("msgn") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma 
			instr_code += "1100001001";
			temp = str.substr(6, comma1 - 6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("or") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100001011";
			temp = str.substr(4, comma1 - 4);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("popcntw") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100001100";
			temp = str.substr(9, comma1 - 9);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.substr(0, 4) == "rot ") {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100001101";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("rotw") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100001110";
			temp = str.substr(6, comma1 - 6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("shlhi") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100001111";
			temp = str.substr(7, comma1 - 7);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.substr(0, 4) == "sfh ") {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100010000";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("sfw") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100010001";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("sfhs") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100010010";
			temp = str.substr(6, comma1 - 6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("nand") != string::npos) {
			string rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "1100010011";
			temp = str.substr(6, comma1 - 6);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			temp = str.substr(comma2 + 3);
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			instr_code += (rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("000") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10000";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("001") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10001";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("010") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10010";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("011") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10011";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("100") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10100";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("101") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10101";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("110") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10110";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
		else if (str.find("111") != string::npos) {
			string rs3, rs2, rs1, rd;
			int comma1 = str.find(","); //1st comma pos
			instr_code += "10111";
			temp = str.substr(5, comma1 - 5);
			int rd_index = stoi(temp);
			rd = decToBinary(rd_index, 5);
			int comma2 = str.find(",", comma1 + 1); //2nd comma pos
			temp = str.substr(comma1 + 3, comma2 - (comma1 + 3)); //comma1 + 3 = rs1 index start
			int rs1_index = stoi(temp);
			rs1 = decToBinary(rs1_index, 5);
			int comma3 = str.find(",", comma2 + 1); //3rd comma pos
			temp = str.substr(comma2 + 3, comma3 - (comma2 + 3)); //comma2 + 3 = rs2 index start
			int rs2_index = stoi(temp);
			rs2 = decToBinary(rs2_index, 5);
			temp = str.substr(comma3 + 3); //rs3 index start
			int rs3_index = stoi(temp);
			rs3 = decToBinary(rs3_index, 5);
			instr_code += (rs3 + rs2 + rs1 + rd);
			output << instr_code << endl;
			instr_code.clear();
		}
	}
	input.close();
	output.close();
	return 0;
}