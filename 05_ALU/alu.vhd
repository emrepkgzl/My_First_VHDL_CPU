library ieee;
use ieee.std_logic_1164.all;

entity alu is

	port(
		A			:	in	std_logic_vector(3 downto 0);
		B			:	in	std_logic_vector(3 downto 0);
		OpCode	:	in std_logic_vector(1 downto 0);
		
		Result	:	out std_logic_vector(3 downto 0)
	);

end entity alu;


architecture bhv of alu is

	component four_bit_adder is

		port(
			A		:	in	std_logic_vector(3 downto 0);
			B		:	in	std_logic_vector(3 downto 0);
			Cin	:	in std_logic;
			
			S		:	out std_logic_vector(3 downto 0);
			Cout	:	out std_logic
		);

	end component four_bit_adder;
	
	signal adder_B_in	   : std_logic_vector(3 downto 0);
	signal adder_Cin_in	: std_logic;
	
	signal adder_result 	: std_logic_vector(3 downto 0);
	signal and_result 	: std_logic_vector(3 downto 0);
	signal or_result 		: std_logic_vector(3 downto 0);
	
	signal unused_cout	: std_logic;

begin

	adder_inst	:	four_bit_adder
		port map(
		
			A		=> A,
			B		=> adder_B_in,
			Cin 	=> adder_Cin_in,
			
			S		=> adder_result,
			Cout	=> unused_cout
			
		);
		
		and_result <= A and B;
		
		or_result  <= A or B;
		
		ALU_control_process	:	process(OpCode, B, adder_result, and_result, or_result)
		begin
		
			adder_B_in <= (others => 'X');
			adder_Cin_in <= 'X';
			Result <= (others => 'X');
			
			case OpCode is
			
				when "00" =>
					adder_B_in		<= B;
					adder_Cin_in 	<= '0';
					Result 			<= adder_result;
					
				when "01" => 
					adder_B_in		<= not B;
					adder_Cin_in 	<= '1';
					Result 			<= adder_result;
					
				when "10" =>
					Result <= and_result;
					
				when "11" =>
					Result <= or_result;
					
				when others =>
					adder_B_in <= (others => 'X');
					adder_Cin_in <= 'X';
					Result <= (others => 'X');
					
			end case;
		
		end process ALU_control_process;

end architecture bhv;