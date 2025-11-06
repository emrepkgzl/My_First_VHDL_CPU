library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_4bit is
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		
		Q		: out	std_logic_vector(3 downto 0)
	);
end entity counter_4bit;

architecture bhv of counter_4bit is
	
	signal s_count	: std_logic_vector(3 downto 0)	:=	(others => '0');
	
begin

	main_process	: process(clk, rst)
	begin
	
		if(rst = '1') then
			
			s_count <= "0000";
			
		elsif	rising_edge(clk) then
		
			s_count <= std_logic_vector(unsigned(s_count) + 1);
		
		end if;
		
	end process main_process;
	
	Q <= s_count;
	
end architecture bhv;