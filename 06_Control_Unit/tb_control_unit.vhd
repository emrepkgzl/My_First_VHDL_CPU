library ieee;
use ieee.std_logic_1164.all;

entity tb_control_unit is
end entity tb_control_unit;

architecture test of tb_control_unit is

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
				
				Reg_Write_Enable	:	out std_logic
			);

	end component control_unit;
	
	constant CLK_PERIOD 			: time := 20 ns;
	
	signal s_clk					: std_logic := '0';
	signal s_rst					: std_logic := '0';
	signal s_Instr_OpCode		: std_logic_vector(3 downto 0) := "0000";
	signal s_Zero_Flag_In		: std_logic := '0';
	
	signal s_PC_Load_Enable		: std_logic;
	signal s_PC_Enable			: std_logic;
	signal s_ROM_Enable			: std_logic;
	signal s_Reg_Write_Enable	: std_logic;
	signal s_ALU_OpCode_Out		: std_logic_vector(3 downto 0);

begin

	UUT : control_unit
		port map(
			clk					=> s_clk,
			rst					=> s_rst,
			Instr_OpCode		=> s_Instr_OpCode,
			Zero_Flag_In		=> s_Zero_Flag_In,
			ALU_OpCode_Out 	=> s_ALU_OpCode_Out,
			PC_Load_Enable		=> s_PC_Load_Enable,
			PC_Enable			=> s_PC_Enable,
			ROM_Enable			=> s_ROM_Enable,
			Reg_Write_Enable	=> s_Reg_Write_Enable
		);
		
	clk_process : process
	begin
	
		s_clk <= '0';
		wait for CLK_PERIOD / 2;
		s_clk <= '1';
		wait for CLK_PERIOD / 2;
		
	end process clk_process;
	
	stim_process : process
	begin
	
		s_rst <= '1';
		s_Instr_OpCode <= "0000";
		wait for 30 ns;
		
		s_rst <= '0';
		
		-- wait for fetch-decode-execute process
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Instr_OpCode <= "1001";
		s_Zero_Flag_In <= '0';
		
		-- wait for fetch-decode-execute process
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Instr_OpCode <= "1001";
		s_Zero_Flag_In <= '1';
		
		-- wait for fetch-decode-execute process
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Instr_OpCode <= "1000";
		s_Zero_Flag_In <= '0';
		
		-- wait for fetch-decode-execute process
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		wait;
	
	end process stim_process;

end architecture test;