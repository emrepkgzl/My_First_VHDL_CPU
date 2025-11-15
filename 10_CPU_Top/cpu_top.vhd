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
			A			:	in	std_logic_vector(3 downto 0);
			B			:	in	std_logic_vector(3 downto 0);
			OpCode	:	in std_logic_vector(1 downto 0);
			
			Result	:	out std_logic_vector(3 downto 0)
		);

	end component alu;
	
	component control_unit is

		port(
			clk					:	in		std_logic;
			rst					:	in		std_logic;

			Instr_OpCode		:	in		std_logic_vector(1 downto 0);
			ALU_OpCode_Out		:	out	std_logic_vector(1 downto 0);
			
			PC_Enable			:	out	std_logic;
			ROM_Enable			:	out	std_logic;
			
			Reg_Write_Enable	:	out 	std_logic
		);

	end component control_unit;
	
	component instruction_rom is

		port(
			clk		: in std_logic;
			Enable 	: in std_logic;
			Address	: in std_logic_vector(3 downto 0);
			
			Data_Out	: out std_logic_vector(1 downto 0)
		);

	end component instruction_rom;
	
	component program_counter is
	
		port(
			clk		: in std_logic;
			rst		: in std_logic;
			
			Enable	: in std_logic;
			Q			: out	std_logic_vector(3 downto 0)
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
	
	--signals that are produced by control_unit
	signal w_pc_enable		: std_logic;
	signal w_rom_enable		: std_logic;
	signal w_alu_opcode		: std_logic_vector(1 downto 0);
	signal w_reg_write_en	: std_logic;
	
	--signal that is produced by program counter
	signal w_pc_address		: std_logic_vector(3 downto 0);
	
	--signal that is produced by instruction_rom
	signal w_rom_opcode		: std_logic_vector(1 downto 0);
	
	--signals that are produced by register_file
	signal w_reg_out_a		: std_logic_vector(3 downto 0);
	signal w_reg_out_b		: std_logic_vector(3 downto 0);
	
	--signal that is produced by alu
	signal w_alu_result		: std_logic_vector(3 downto 0);
	
	signal w_addr_read_a		: std_logic_vector(3 downto 0) := "0001";
	signal w_addr_read_b		: std_logic_vector(3 downto 0) := "0010";
	signal w_addr_write		: std_logic_vector(3 downto 0) := "0011";
	
begin

	Control_Unit_Inst	: control_unit
		
		port map(
			clk					=> clk_main,
			rst					=> rst_main,
			Instr_OpCode		=> w_rom_opcode,
			ALU_OpCode_Out		=> w_alu_opcode,
			PC_Enable			=> w_pc_enable,
			ROM_Enable			=> w_rom_enable,
			Reg_Write_Enable	=> w_reg_write_en
		);
		
	PC_Inst	: program_counter
	
		port map(
			clk		=> clk_main,
			rst		=> rst_main,
			Enable	=> w_pc_enable,
			Q			=> w_pc_address
		);
			
	ROM_Inst	: instruction_rom
	
		port map(
			clk		=> clk_main,
			Enable 	=> w_rom_enable,
			Address	=> w_pc_address,
			Data_Out	=> w_rom_opcode
		);
		
	RegFile_Inst	: register_file
	
		port map(
			clk				=> clk_main,
			rst				=> rst_main,
			Write_Enable	=> w_reg_write_en,
			Addr_Write		=> w_addr_write,
			Data_In			=> w_alu_result,
			Addr_Read_A		=> w_addr_read_a,
			Data_Out_A		=> w_reg_out_a,
			Addr_Read_B		=> w_addr_read_b,
			Data_Out_B		=> w_reg_out_b
		);
		
	ALU_Inst	: alu
	
		port map(
			A			=> w_reg_out_a,
			B			=> w_reg_out_b,
			OpCode	=> w_alu_opcode,
			Result	=> w_alu_result
		);
		
	Debug_ALU_Result <= w_alu_result;

end architecture bhv;