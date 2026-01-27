library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_top is

	port(
	
		clk_main				: in std_logic;
		rst_main				: in std_logic;
		
		Debug_ALU_Result	: out std_logic_vector(3 downto 0)
		
	);

end entity cpu_top;

architecture bhv of cpu_top is

	component alu is

		port(
			A				:	in	std_logic_vector(3 downto 0);
			B				:	in	std_logic_vector(3 downto 0);
			OpCode		:	in std_logic_vector(3 downto 0);
			
			Result		:	out std_logic_vector(3 downto 0);
			Zero_Flag	:	out std_logic;
			Carry_Flag	:	out std_logic;
			Neg_Flag		:	out std_logic
		);

	end component alu;
	
	component control_unit is

		port(
				clk					:	in		std_logic;
				rst					:	in		std_logic;

				Instr_OpCode		:	in		std_logic_vector(3 downto 0);
				Zero_Flag_In		:  in		std_logic;
				ALU_OpCode_Out		:	out	std_logic_vector(3 downto 0);
				
				PC_Load_Enable		:	out	std_logic;
				PC_Enable			:	out	std_logic;
				ROM_Enable			:	out	std_logic;
				
				Reg_Write_Enable	:	out std_logic;
				RAM_Write_Enable	:	out std_logic
			);

	end component control_unit;
	
	component instruction_rom is

		port(
			clk		: in std_logic;
			Enable 	: in std_logic;
			Address	: in std_logic_vector(3 downto 0);
			
			Data_Out	: out std_logic_vector(15 downto 0)
		);

	end component instruction_rom;
	
	component program_counter is
	
		port(
			clk			: in std_logic;
			rst			: in std_logic;
			
			Enable		: in std_logic;
			Load_Enable	: in std_logic;
			Data_In		: in std_logic_vector(3 downto 0);
			
			Q				: out	std_logic_vector(3 downto 0)
		);
		
	end component program_counter;
	
	component register_file is

		port(
		
			--main control signals
			clk				: in std_logic;
			rst				: in std_logic;
			Write_Enable	: in std_logic;
			
			--write port		
			Addr_Write	: in std_logic_vector(3 downto 0);
			Data_In		: in std_logic_vector(3 downto 0);
			
			--read port A
			Addr_Read_A	: in std_logic_vector(3 downto 0);
			Data_Out_A	: out	std_logic_vector(3 downto 0);
			
			--read port B
			Addr_Read_B	: in std_logic_vector(3 downto 0);
			Data_Out_B	: out std_logic_vector(3 downto 0)
			
		);

	end component register_file;
	
	component data_memory is

		port(
			
			clk				: in std_logic;
			Write_Enable	: in std_logic;
			Address			: in std_logic_vector(3 downto 0);
			
			Data_In			: in std_logic_vector(3 downto 0);
			Data_Out			: out std_logic_vector(3 downto 0)
			
		);

	end component data_memory;
	
	--signals that are produced by control_unit
	signal w_pc_enable		: std_logic;
	signal w_pc_load_enable	: std_logic;
	signal w_rom_enable		: std_logic;
	signal w_alu_opcode		: std_logic_vector(3 downto 0);
	signal w_reg_write_en	: std_logic;
	signal w_ram_write_en	: std_logic;
	
	--signal that is produced by program counter
	signal w_pc_address		: std_logic_vector(3 downto 0);
	
	--signal that is produced by instruction_rom
	signal w_instruction		: std_logic_vector(15 downto 0);
	
	--signals that are obtained by parsing w_instruction
	signal w_opcode_from_rom	: std_logic_vector(3 downto 0);
	signal w_addr_write		: std_logic_vector(3 downto 0);
	signal w_addr_read_a		: std_logic_vector(3 downto 0);
	signal w_addr_read_b		: std_logic_vector(3 downto 0);
	
	--signals that are produced by register_file
	signal w_reg_out_a		: std_logic_vector(3 downto 0);
	signal w_reg_out_b		: std_logic_vector(3 downto 0);
	
	--signal that is produced by alu
	signal w_alu_result		: std_logic_vector(3 downto 0);
	signal w_zero_flag		: std_logic;
	signal w_carry_flag		: std_logic;
	signal w_neg_flag			: std_logic;
	
	signal w_alu_B_input		: std_logic_vector(3 downto 0);
	signal w_ram_data_out	: std_logic_vector(3 downto 0);
	signal w_reg_write_data	: std_logic_vector(3 downto 0);
	
begin

	--parsing
	w_opcode_from_rom	<= w_instruction(15 downto 12);
	w_addr_write		<= w_instruction(11 downto 8);
	w_addr_read_a		<= w_instruction(7 downto 4);
	w_addr_read_b		<= w_instruction(3 downto 0);
	
	--MUX
	w_alu_B_input		<= w_addr_read_b when (w_alu_opcode = "1000") else w_reg_out_b;
	w_reg_write_data	<= w_ram_data_out when (w_opcode_from_rom = "1100") else w_alu_result;

	Control_Unit_Inst	: control_unit
		
		port map(
			clk					=> clk_main,
			rst					=> rst_main,
			Instr_OpCode		=> w_opcode_from_rom,
			Zero_Flag_In		=> w_zero_flag,
			ALU_OpCode_Out		=> w_alu_opcode,
			PC_Enable			=> w_pc_enable,
			PC_Load_Enable		=> w_pc_load_enable,
			ROM_Enable			=> w_rom_enable,
			Reg_Write_Enable	=> w_reg_write_en,
			RAM_write_enable	=> w_ram_write_en
		);
		
	PC_Inst	: program_counter
	
		port map(
			clk			=> clk_main,
			rst			=> rst_main,
			Enable		=> w_pc_enable,
			Load_Enable	=> w_pc_load_enable,
			Data_In		=> w_addr_write,
			Q				=> w_pc_address
		);
			
	ROM_Inst	: instruction_rom
	
		port map(
			clk		=> clk_main,
			Enable 	=> w_rom_enable,
			Address	=> w_pc_address,
			Data_Out	=> w_instruction
		);
		
	RegFile_Inst	: register_file
	
		port map(
			clk				=> clk_main,
			rst				=> rst_main,
			Write_Enable	=> w_reg_write_en,
			Addr_Write		=> w_addr_write,
			Data_In			=> w_reg_write_data,
			Addr_Read_A		=> w_addr_read_a,
			Data_Out_A		=> w_reg_out_a,
			Addr_Read_B		=> w_addr_read_b,
			Data_Out_B		=> w_reg_out_b
		);
		
	ALU_Inst	: alu
	
		port map(
			A				=> w_reg_out_a,
			B				=> w_alu_B_input,
			OpCode		=> w_alu_opcode,
			Zero_Flag	=> w_zero_flag,
			Carry_Flag	=> w_carry_flag,
			Neg_Flag		=> w_neg_flag,
			Result		=> w_alu_result
		);
	
	Data_Memory_Inst	: data_memory
		
		port map(
			
			clk				=> clk_main,
			Write_Enable	=> w_ram_write_en,
			Address			=> w_reg_out_a,
			Data_In			=> w_reg_out_b,
			Data_Out			=> w_ram_data_out			
		
		);
		
	Debug_ALU_Result <= w_alu_result;

end architecture bhv;