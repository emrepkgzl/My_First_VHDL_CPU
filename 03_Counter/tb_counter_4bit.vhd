library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_4bit is
end entity tb_counter_4bit;

architecture test of tb_counter_4bit is

	component counter_4bit is
		port(
			clk	: in std_logic;
			rst	: in std_logic;
			
			Q		: out	std_logic_vector(3 downto 0)
		);
	end component counter_4bit;
	
	signal s_clk	:	std_logic := '0';
	signal s_rst	:	std_logic := '0';
	
	signal s_Q		:	std_logic_vector(3 downto 0);
	
begin

	UUT	: counter_4bit
		port map(
			clk => s_clk,
			rst => s_rst,
			Q	 => s_Q
		);
		
	clk_process	: process
	begin
	
		s_clk <= '0';
		wait for 10 ns;
		s_clk <= '1';
		wait for 10 ns;
		
	end process clk_process;
	
	stim_process	: process
	begin
		s_rst <= '1';
		wait for 30 ns;
		
		s_rst <= '0';
		
		wait for 330 ns;
		s_rst <= '1';
		
		wait;
		
	end process stim_process;
		
end architecture test;
