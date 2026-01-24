library ieee;
use ieee.std_logic_1164.all;

entity tb_program_counter is
end entity tb_program_counter;

architecture test of tb_program_counter is

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
	
	constant CLK_PERIOD : time := 20 ns;
	
	signal s_clk			:	std_logic := '0';
	signal s_rst			:	std_logic := '0';
	
	signal s_Enable		:  std_logic := '0';
	signal s_Load_Enable	:  std_logic := '0';
	signal s_Data_In		:	std_logic_vector(3 downto 0) := (others => '0');
	
	signal s_Q				:	std_logic_vector(3 downto 0);
	
begin

	UUT	: program_counter
		port map(
			clk			=> s_clk,
			rst 			=> s_rst,
			Enable		=> s_Enable,
			Load_Enable	=> s_Load_Enable,
			Data_In		=> s_Data_In,
			Q	 			=> s_Q
		);
		
	clk_process	: process
	begin
	
		s_clk <= '0';
		wait for CLK_PERIOD / 2;
		s_clk <= '1';
		wait for CLK_PERIOD / 2;
		
	end process clk_process;
	
	stim_process	: process
	begin
		s_rst <= '1';
		s_Enable <= '0';
		wait for 30 ns;
		
		s_rst <= '0';
		s_Enable <= '1';
		
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Enable <= '0';
		
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Enable <= '1';
		
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Data_In		<= "1010";
		s_Load_Enable	<= '1';
		
		wait for CLK_PERIOD;
		
		s_Data_In		<= "1011";
		s_Load_Enable	<= '0';
		
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Enable <= '0';
		
		wait for CLK_PERIOD;
		wait for CLK_PERIOD;
		
		s_Data_In		<= "0100";
		s_Load_Enable	<= '1';
		
		wait for CLK_PERIOD;
		
		s_Data_In		<= "0100";
		s_Load_Enable	<= '0';
		
		wait for CLK_PERIOD;
		
		wait;
		
	end process stim_process;
		
end architecture test;
