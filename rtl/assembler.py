"""
-----------------------------------------------------
 File Name        :   assembler.sv
 Function         :   Basic assembler 
 Author           :   Peter Alexander
 Last rev. 26 Mar 2021
-----------------------------------------------------
"""

from os import O_APPEND


def get_opcodes() -> dict:
    """Parse the possible opcodes and their binary representation from
    the opcodes.sv file.
    
    :returns: A dict with format: ["NOP":0b000000]
    """

    # Get file contents
    with open("./opcodes.sv", "r") as opcode_file:
        opcode_lines = opcode_file.readlines()

    # Filter out header and newlines and "`define " prefix
    filtered_opcode_lines = []

    for idx, line in enumerate(opcode_lines):
        if line[0] == "`":
            filtered_opcode_lines.append(line[8:])

    # Split remaining lines into tokens
    opcode_line_tokens = [line.split() for line in filtered_opcode_lines]

    # Get lists for opcodes and their binary representations
    opcode_list = [token[0] for token in opcode_line_tokens]
    binary_list = [token[1][3:] for token in opcode_line_tokens]

    # Generate a dict from these lists
    opcode_dict = dict(zip(opcode_list, binary_list))

    return(opcode_dict, opcode_list, binary_list)


def get_program_tokens(file_name="./prog.a") -> list:
    """Split the input file into lines and split those lines into tokens for
    further processing.
    
    :returns: List of token lists
    """

    # Get file prog.a file contents 
    with open(file_name,"r") as prog_file:
        prog_lines = prog_file.readlines()

    # Filter out any newlines or lines beginning with "#" characters
    filtered_prog_lines = []
    prog_line_numbers = []

    for idx, line in enumerate(prog_lines):
        if line[0] not in ["#", "\n", "\n\r"]:
            filtered_prog_lines.append(line)
            prog_line_numbers.append(idx + 1)

    # Split those lines into tokens 
    prog_tokens = [line.split() for line in filtered_prog_lines]

    return prog_tokens, prog_line_numbers, filtered_prog_lines


def check_token_syntax(token_list: list, opcode_list: list, line_nums: list):
    """Check each line has the correct number of tokens and that the opcode is 
    a real opcode.

    :param token_list: The list of tokens generated from the input file.
    :param opcode_list: The list of possible opcodes.
    :param line_nims: The line in the original file where each set of tokens is found
    """

    errors_found = 0

    for idx, line_tokens in enumerate(token_list):

        # Check the opcode is valid
        if line_tokens[0] not in opcode_list:
            errors_found += 1
            print("Syntax Error Line {:3d}: Invalid Opcode".format(line_nums[idx]))

        # Check for correct token number
        if line_tokens[0] == "NOP":
            if len(line_tokens) > 1:
                errors_found += 1
                print("Syntax Error Line {:3d}: NOP Has Arguments".format(line_nums[idx]))
            
        elif len(line_tokens) not in [3,4]:
            errors_found += 1
            print("Syntax Error Line {:3d}: Too Many Arguments".format(line_nums[idx]))
             
    if errors_found > 0:
        print("\nAssembly Failed!")
        print("Errors Found: {}".format(errors_found))


def token_to_bin(tokens, opcode_dict):
    """Convert the tokens generated from the input file into binary strings.

    :param tokens: The tokens generated from the input file.
    :param opcode_dict: A dict matching opcode strings to binary strings.
    :returns: A list of tokens converted into binary strings
    """

    binary_token_list = []

    for token_line in tokens:
        binary_token_line = []

        # Add the opcode as the first token
        binary_token_line.append(opcode_dict[token_line[0]])

        # Skip most of the process for NOP
        if(token_line[0] == "NOP"):
            binary_token_line.append("{:05b}".format(0))
            binary_token_line.append("{:05b}".format(0))
            binary_token_line.append("{:08b}".format(0))
            binary_token_list.append(binary_token_line)
            continue

        # Convert the register values to binary strings
        rd = token_line[1][1:]
        rd_bin = "{:05b}".format(int(rd))

        rs = token_line[2][1:]
        rs_bin = "{:05b}".format(int(rs))

        binary_token_line.append(rd_bin)
        binary_token_line.append(rs_bin)

        # Add the imm token
        if len(token_line) < 4:
            imm_bin = "{:08b}".format(0)
        else:
            imm = int(token_line[3])

            # Format the immediate value in 2's compliment
            if imm < 0:
                imm_bin = "{:08b}".format(255 + imm + 1)
                print(imm_bin) 
            else:   
                imm_bin = "{:08b}".format(imm)

        binary_token_line.append(imm_bin)

        # Append this token line to the token list
        binary_token_list.append(binary_token_line)

    return(binary_token_list)


def bin_to_hex(binary_token_list: list):
    """Combine all binary tokens in each line and generate a hex value.

    :param binary_token_list: The list of binary tokens
    :returns: A list of hex strings and a list of 
    """ 

    hex_list = []
    bin_string_list = []

    for token_line in binary_token_list:
        # Combine binary tokens into one string
        binary_string = "".join(token_line)

        # Convert binary string to int representation
        int_representation = int(binary_string, base=2)

        # Format int representation as hex string
        hex_string = "{:06X}".format(int_representation)

        hex_list.append(hex_string)
        bin_string_list.append(binary_string)

    return hex_list, bin_string_list


def output_program(hex_list, bin_string_list, prog_strings):
    """Generate the lines to write to the hex file and write them to prog.hex.
    Binary representation of each line and original line from .a file written 
    next to each hex value.

    :param hex_list: The list of assembled hex values
    :param bin_string_list: Binary representations of hex strings
    :param prog_strings: The strings from the original .a file  
    """

    output_lines = []

    for hex_string, bin_string, prog_string in zip(hex_list, bin_string_list, prog_strings):
        output_line = "{}\t\t//{}\t{}".format(hex_string, bin_string, prog_string)

        output_lines.append(output_line)

    with open("prog.hex", "w") as output_file:
        output_file.writelines(output_lines)


def main():
    opcode_dict, opcode_list, op_binary_list = get_opcodes()

    # Retrieve tokens from input file
    prog_tokens, prog_line_numbers, prog_strings = get_program_tokens()

    # Do basic syntax check
    check_token_syntax(prog_tokens, opcode_list, prog_line_numbers)

    # Convert each token into a binary string
    binary_token_list = token_to_bin(prog_tokens, opcode_dict)

    # Combine binary strings and get resultant hex values
    hex_list, bin_string_list = bin_to_hex(binary_token_list)

    # Output the assembled program to prog.hex 
    output_program(hex_list, bin_string_list, prog_strings)



if __name__ == "__main__":
    main()

