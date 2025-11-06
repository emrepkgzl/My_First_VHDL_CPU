library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder is
end entity tb_full_adder;

architecture test of tb_full_adder is

	component full_adder is

		port(
		A		:	in std_logic;
		B		:	in std_logic;
		Cin	:	in std_logic;
		
		S		:	out std_logic;
		Cout	: 	out std_logic
		);

	end component full_adder;
	
	signal s_A		:	std_logic := '0';
	signal s_B		:	std_logic := '0';
	signal s_Cin	: 	std_logic := '0';
	
	signal s_S		:	std_logic;
	signal s_Cout	: 	std_logic;
	
begin

	UUT : full_adder
		port map	(
			A		=>	s_A,
			B		=> s_B,
			Cin	=> s_Cin,
			S		=> s_S,
			Cout	=> s_Cout
			
		);
		
		stimulus_process : process
		
		begin
			
			s_A <= '0'; s_B <= '0'; s_Cin <= '0';
			wait for 10 ns;
			
			s_A <= '0'; s_B <= '0'; s_Cin <= '1';
			wait for 10 ns;
			
			s_A <= '0'; s_B <= '1'; s_Cin <= '0';
			wait for 10 ns;
			
			s_A <= '0'; s_B <= '1'; s_Cin <= '1';
			wait for 10 ns;
			
			s_A <= '1'; s_B <= '0'; s_Cin <= '0';
			wait for 10 ns;
			
			s_A <= '1'; s_B <= '0'; s_Cin <= '1';
			wait for 10 ns;
			
			s_A <= '1'; s_B <= '1'; s_Cin <= '0';
			wait for 10 ns;
			
			s_A <= '1'; s_B <= '1'; s_Cin <= '1';
			wait for 10 ns;
			
			wait;
			
			end process stimulus_process;

end architecture test;

