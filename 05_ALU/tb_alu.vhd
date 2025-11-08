library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity tb_alu;

architecture test of tb_alu is

	component alu is
	
		port(
			A			:	in	std_logic_vector(3 downto 0);
			B			:	in	std_logic_vector(3 downto 0);
			OpCode	:	in std_logic_vector(1 downto 0);
			
			Result	:	out std_logic_vector(3 downto 0)
		);

	end component alu;
	
	signal s_A		 :	std_logic_vector(3 downto 0) := (others => '0');
	signal s_B		 :	std_logic_vector(3 downto 0) := (others => '0');
	signal s_OpCode :	std_logic_vector(1 downto 0) := "00";
	
	signal s_Result :	std_logic_vector(3 downto 0);

begin

	UUT	:	alu
		port map(
		
			A		 => s_A,
			B 	    => s_B,
			OpCode => s_OpCode,
			Result => s_Result
			
		);
		
	stim_process	:	process
	begin

		s_A 		<= "0111";
		s_B 		<= "0101";
		s_OpCode <= "00";
		wait for 20 ns;
		
		s_A 		<= "1010";
		s_B 		<= "0011";
		s_OpCode <= "01";
		wait for 20 ns;
		
		s_A 		<= "0100";
		s_B 		<= "0110";
		s_OpCode <= "01";
		wait for 20 ns;
		
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "10";
		wait for 20 ns;
		
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "11";
		wait for 20 ns;
		
		s_A 		<= "0110";
		s_B 		<= "0001";
		s_OpCode <= "XX";
		wait for 20 ns;
		
		wait;
		
	end process stim_process;
	
end architecture test;