library ieee;
use ieee.std_logic_1164.all;

entity control_unit is

	port(
			clk				:	in		std_logic;
			rst				:	in		std_logic;

			Instr_OpCode	:	in		std_logic_vector(1 downto 0);
			ALU_OpCode_Out	:	out	std_logic_vector(1 downto 0);
			
			PC_Enable		:	out	std_logic;
			ROM_Enable		:	out	std_logic
		);

end entity control_unit;

architecture bhv of control_unit is

	type state_t is (FETCH, DECODE, EXECUTE);
	
	signal current_state	:	state_t := FETCH;
	signal next_state		:	state_t := FETCH;
	
begin

	process_sync	:	process(clk, rst)
	begin
	
		if(rst = '1') then
			current_state <= FETCH;
			
		elsif (rising_edge(clk)) then
			current_state <= next_state;
			
		end if;
		
	end process process_sync;
	
	process_comb	:	process(current_state, Instr_OpCode)
	begin
	
		ALU_OpCode_Out <= (others => 'X');
		PC_Enable 		<= '0';
		ROM_Enable 		<= '0';
		next_state		<= FETCH;
		
		case current_state is
		
			when FETCH =>
				ROM_Enable <= '1';
				PC_Enable  <= '1';
				
				next_state <= DECODE;
				
			when DECODE =>
				next_state <= EXECUTE;
				
			when EXECUTE =>
				ALU_OpCode_Out <= Instr_OpCode;
				next_state <= FETCH;
				
		end case;
		
	end process process_comb;

end architecture bhv;