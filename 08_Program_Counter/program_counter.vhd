library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
	port(
		clk		: in std_logic;
		rst		: in std_logic;
		
		Enable	: in std_logic;
		Q			: out	std_logic_vector(3 downto 0)
	);
end entity program_counter;

architecture bhv of program_counter is
	
	signal s_count	: std_logic_vector(3 downto 0)	:=	(others => '0');
	
begin

	main_process	: process(clk, rst)
	begin
	
		if(rst = '1') then
			
			s_count <= "0000";
			
		elsif	rising_edge(clk) then
		
			if(Enable = '1') then
			
				s_count <= std_logic_vector(unsigned(s_count) + 1);
				
			end if;
		
		end if;
		
	end process main_process;
	
	Q <= s_count;
	
end architecture bhv;