library ieee;
use ieee.std_logic_1164.all;

entity tb_four_bit_adder is
end entity tb_four_bit_adder;

architecture test of tb_four_bit_adder is

	component four_bit_adder is

		port(
			A		:	in	std_logic_vector(3 downto 0);
			B		:	in	std_logic_vector(3 downto 0);
			Cin	:	in std_logic;
			
			S		:	out std_logic_vector(3 downto 0);
			Cout	:	out std_logic
		);

	end component four_bit_adder;
	
	signal s_A		:	std_logic_vector(3 downto 0) := (others => '0');
	signal s_B		:	std_logic_vector(3 downto 0) := (others => '0');
	signal s_Cin	:	std_logic := '0';
	
	signal s_S		: 	std_logic_vector(3 downto 0);
	signal s_Cout	:	std_logic;
	
begin

	UUT	: four_bit_adder
		port map(
			A		=> s_A,
			B		=> s_B,
			Cin	=> s_Cin,
			
			S		=> s_S,
			Cout	=> s_Cout
		);
		
		
	stimulus_process	: process
	begin
	
		s_A <= "0000";
		s_B <= "0000";
		s_Cin <= '0';
		wait for 10 ns;
		
		s_A <= "0011";
		s_B <= "0101";
		s_Cin <= '0';
		wait for 10 ns;
		
		s_A <= "0111";
		s_B <= "0001";
		s_Cin <= '0';
		wait for 10 ns;
		
		s_A <= "0101";
		s_B <= "0101";
		s_Cin <= '0';
		wait for 10 ns;
		
		s_A <= "1010";
		s_B <= "1000";
		s_Cin <= '1';
		wait for 10 ns;
		
		s_A <= "1111";
		s_B <= "1111";
		s_Cin <= '1';
		wait for 10 ns;
		
		wait;
		
	end process stimulus_process;
		
end architecture test;