library ieee;
use ieee.std_logic_1164.all;

entity tb_cpu_top is
end entity tb_cpu_top;

architecture test of tb_cpu_top is

	component cpu_top is

		port(
		
			clk_main				: in std_logic;
			rst_main				: in std_logic;
			
			Debug_ALU_Result	: out std_logic_vector(3 downto 0)
			
		);
	
	end component cpu_top;
	
	constant CLK_PERIOD : time := 20 ns;
	
	signal s_clk	: std_logic := '0';
	signal s_rst 	: std_logic := '0';
	
	signal sim_done: boolean := false;
	
	signal s_Debug_ALU_Result : std_logic_vector(3 downto 0);

begin

	UUT	: cpu_top
		port map(
			clk_main				=> s_clk,
			rst_main				=> s_rst,
			Debug_ALU_Result	=> s_Debug_ALU_Result
		);
		
	clk_process	: process
	begin
	
		while not sim_done loop
			s_clk <= '0';
			wait for CLK_PERIOD / 2;
			s_clk <= '1';
			wait for CLK_PERIOD / 2;
		end loop;
		wait;
		
	end process clk_process;
	
	stim_process	: process
	begin
	
		s_rst <= '1';
		wait for 30 ns;
		
		s_rst <= '0';
		
		--wait for execution of rom content
		wait for 900 ns;
		sim_done <= true;
		wait;
		
	end process stim_process;

end architecture test;