library ieee;
use ieee.std_logic_1164.all;

entity control_unit is

	port(
			clk					:	in		std_logic;
			rst					:	in		std_logic;

			Instr_OpCode		:	in		std_logic_vector(3 downto 0);
			Zero_Flag_In		:  in		std_logic;
			ALU_OpCode_Out		:	out	std_logic_vector(3 downto 0);
			
			PC_Load_Enable		:	out	std_logic;
			PC_Enable			:	out	std_logic;
			ROM_Enable			:	out	std_logic;
			
			Reg_Write_Enable	:	out std_logic;
			RAM_Write_Enable	:	out std_logic
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
	
	process_comb	:	process(current_state, Instr_OpCode, Zero_Flag_In)
	begin
	
		ALU_OpCode_Out 	<= (others => '0');
		PC_Load_Enable		<= '0';
		PC_Enable 			<= '0';
		ROM_Enable 			<= '0';
		Reg_Write_Enable	<= '0';
		RAM_Write_Enable	<= '0';
		next_state			<= FETCH;
		
		case current_state is
		
			when FETCH =>
				ROM_Enable <= '1';
				PC_Enable  <= '1';
				
				next_state <= DECODE;
				
			when DECODE =>
				next_state <= EXECUTE;
				
			when EXECUTE =>
			
				case Instr_OpCode is
				
					when "1001" =>
					
						ALU_OpCode_Out		<= "0001"; --SUB
						Reg_Write_Enable	<= '0';
						RAM_Write_Enable	<= '0';
						
						if(Zero_Flag_In = '1') then
							
							PC_Load_Enable <= '1';
							
						else
						
							PC_Load_Enable <= '0';
							
						end if;
						
					when "1100" =>
					
						ALU_OpCode_Out		<= Instr_OpCode;
						Reg_Write_Enable	<= '1';
						RAM_Write_Enable	<= '0';
						
					when "1101" =>
					
						ALU_OpCode_Out		<= Instr_OpCode;
						Reg_Write_Enable	<= '0';
						RAM_Write_Enable	<= '1';
						
					when others =>					
			
						ALU_OpCode_Out 	<= Instr_OpCode;
						Reg_Write_Enable 	<= '1';
						RAM_Write_Enable	<= '0';
						PC_Load_Enable		<= '0';
						
					end case;
					
				
				next_state <= FETCH;
				
		end case;
		
	end process process_comb;

end architecture bhv;