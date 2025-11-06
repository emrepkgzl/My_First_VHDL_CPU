library ieee;
use ieee.std_logic_1164.all;

entity tb_sequence_detector is
end entity tb_sequence_detector;

architecture test of tb_sequence_detector is

component sequence_detector is

	port(
		clk		:	in		std_logic;
		rst		:	in		std_logic;
		data_in	:	in		std_logic;
		found_it	:	out	std_logic
	);
	
end component sequence_detector;

constant CLK_PERIOD	:	time := 20 ns;

signal s_clk		:	std_logic;
signal s_rst		:	std_logic;
signal s_data_in	:	std_logic;

signal s_found_it	:	std_logic;

begin

	UUT	:	sequence_detector
		port map(
			clk 		=> s_clk,
			rst		=> s_rst,
			data_in	=> s_data_in,
			found_it	=> s_found_it
		);
		
	clk_process	:	process
	begin
		
		s_clk <= '0';
		wait for CLK_PERIOD / 2;
		s_clk <= '1';
		wait for CLK_PERIOD / 2;
		
	end process clk_process;
	
	stim_process : process
	begin
	
		s_rst <= '1';
		wait for 30 ns;
		
		s_rst <= '0';
		wait for 10 ns;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '0';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '0';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		s_data_in <= '0';
		wait for CLK_PERIOD;
		
		s_data_in <= '0';
		wait for CLK_PERIOD;
		
		s_data_in <= '1';
		wait for CLK_PERIOD;
		
		wait;
		
	end process stim_process;
		
end architecture test;