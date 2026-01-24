library ieee;
use ieee.std_logic_1164.all;

entity alu is

	port(
		A				:	in	std_logic_vector(3 downto 0);
		B				:	in	std_logic_vector(3 downto 0);
		OpCode		:	in std_logic_vector(3 downto 0);
		
		Result		:	out std_logic_vector(3 downto 0);
		Zero_Flag	:	out std_logic;
		Carry_Flag	:	out std_logic;
		Neg_Flag		:	out std_logic
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
	signal adder_cout		: std_logic;
	signal and_result 	: std_logic_vector(3 downto 0);
	signal nand_result 	: std_logic_vector(3 downto 0);
	signal or_result 		: std_logic_vector(3 downto 0);
	signal xor_result 	: std_logic_vector(3 downto 0);
	signal lshift_result : std_logic_vector(3 downto 0);
	signal rshift_result : std_logic_vector(3 downto 0);
	
	signal s_result		: std_logic_vector(3 downto 0);

begin

	adder_inst	:	four_bit_adder
		port map(
		
			A		=> A,
			B		=> adder_B_in,
			Cin 	=> adder_Cin_in,
			
			S		=> adder_result,
			Cout	=> adder_cout
			
		);
		
		and_result		<= A and B;
		or_result		<= A or B;
		xor_result		<= A xor B;
		nand_result		<= not(and_result);
		lshift_result	<= A(2 downto 0) & '0';
		rshift_result	<= '0' & A(3 downto 1);
		
		
		ALU_control_process	:	process(OpCode, B, adder_result, and_result, or_result, xor_result, nand_result, lshift_result, rshift_result, adder_cout)
		begin
		
			adder_B_in		<= (others => '0');
			adder_Cin_in	<= '0';
			s_result			<= (others => '0');
			Carry_Flag		<= '0';
			
			case OpCode is
			
				when "0000" =>
					adder_B_in		<= B;
					adder_Cin_in 	<= '0';
					s_result 		<= adder_result;
					Carry_Flag		<= adder_cout;
					
				when "0001" => 
					adder_B_in		<= not B;
					adder_Cin_in 	<= '1';
					s_result 		<= adder_result;
					Carry_Flag		<= not(adder_cout);
					
				when "0010" =>
					s_result <= and_result;
					
				when "0011" =>
					s_result <= or_result;
					
				when "0100" =>
					s_result <= xor_result;
					
				when "0101" =>
					s_result <= nand_result;
					
				when "0110" =>
					s_result <= lshift_result;
					
				when "0111" =>
					s_result <= rshift_result;
					
				when "1000" =>
					s_result <= B;
					
				when others =>
					adder_B_in <= (others => 'X');
					adder_Cin_in <= 'X';
					s_result <= (others => 'X');
					
			end case;
		
		end process ALU_control_process;
		
		Zero_Flag	<= '1' when (s_result = "0000") else '0';
		Neg_Flag		<= s_result(3);
		Result 		<= s_result;

end architecture bhv;