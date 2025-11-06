library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is

	port(
		A		:	in	std_logic_vector(3 downto 0);
		B		:	in	std_logic_vector(3 downto 0);
		Cin	:	in std_logic;
		
		S		:	out std_logic_vector(3 downto 0);
		Cout	:	out std_logic
	);

end entity four_bit_adder;

architecture bhv of four_bit_adder is

	component full_adder is

		port(
			A		:	in std_logic;
			B		:	in std_logic;
			Cin	:	in std_logic;
			
			S		:	out std_logic;
			Cout	: 	out std_logic
			);

	end component full_adder;
	
	signal c_internal	:	std_logic_vector(2 downto 0);
	
begin
	
	FA0 :	component full_adder
		port map (
			A		=> A(0),
			B 		=> B(0),
			Cin	=> Cin,
			S		=> S(0),
			Cout	=> c_internal(0)
		);
		
		
	FA1 :	component full_adder
		port map (
			A		=> A(1),
			B 		=> B(1),
			Cin	=> c_internal(0),
			S		=> S(1),
			Cout	=> c_internal(1)
		);
		
		
	FA2 :	component full_adder
		port map (
			A		=> A(2),
			B 		=> B(2),
			Cin	=> c_internal(1),
			S		=> S(2),
			Cout	=> c_internal(2)
		);
		
		
	FA3 :	component full_adder
		port map (
			A		=> A(3),
			B 		=> B(3),
			Cin	=> c_internal(2),
			S		=> S(3),
			Cout	=> Cout
		);

		
end architecture bhv;
