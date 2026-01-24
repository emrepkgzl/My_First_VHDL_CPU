library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity tb_alu;

architecture test of tb_alu is

	component alu is
	
		port(
			A				:	in	std_logic_vector(3 downto 0);
			B				:	in	std_logic_vector(3 downto 0);
			OpCode		:	in std_logic_vector(3 downto 0);
			
			Result		:	out std_logic_vector(3 downto 0);
			Zero_Flag	:	out std_logic;
			Carry_Flag	:	out std_logic;
			Neg_Flag		:	out std_logic
		);

	end component alu;
	
	signal s_A		 :	std_logic_vector(3 downto 0) := (others => '0');
	signal s_B		 :	std_logic_vector(3 downto 0) := (others => '0');
	signal s_OpCode :	std_logic_vector(3 downto 0) := "0000";
	
	signal s_Result :	std_logic_vector(3 downto 0);
	signal s_Zero, s_Carry, s_Neg	:	std_logic;

begin

	UUT	:	alu
		port map(
		
			A		 		=> s_A,
			B 	    		=> s_B,
			OpCode 		=> s_OpCode,
			Result 		=> s_Result,
			Zero_Flag	=> s_Zero,
			Carry_Flag	=> s_Carry,
			Neg_Flag		=> s_Neg
		);
		
	stim_process	:	process
	begin

		--ADD
		s_A 		<= "1000";
		s_B 		<= "1010";
		s_OpCode <= "0000";
		wait for 20 ns;
		
		--SUB
		s_A 		<= "0010";
		s_B 		<= "0101";
		s_OpCode <= "0001";
		wait for 20 ns;
		
		--SUB
		s_A 		<= "0100";
		s_B 		<= "0100";
		s_OpCode <= "0001";
		wait for 20 ns;
		
		--AND
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "0010";
		wait for 20 ns;
		
		--OR
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "0011";
		wait for 20 ns;
		
		--XOR
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "0100";
		wait for 20 ns;
		
		--NAND
		s_A 		<= "1010";
		s_B 		<= "1100";
		s_OpCode <= "0101";
		wait for 20 ns;
		
		--LSHIFT
		s_A 		<= "0110";
		s_B 		<= "0000";
		s_OpCode <= "0110";
		wait for 20 ns;
		
		--RSHIFT
		s_A 		<= "0110";
		s_B 		<= "0000";
		s_OpCode <= "0111";
		wait for 20 ns;
		
		--IM
		s_A 		<= "0000";
		s_B 		<= "1111";
		s_OpCode <= "1000";
		wait for 20 ns;
		
		--UNDECLARED
		s_A 		<= "0110";
		s_B 		<= "0001";
		s_OpCode <= "XXXX";
		wait for 20 ns;
		
		wait;
		
	end process stim_process;
	
end architecture test;