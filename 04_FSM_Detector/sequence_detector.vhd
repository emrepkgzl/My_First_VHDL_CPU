library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector is

	port(
		clk		:	in		std_logic;
		rst		:	in		std_logic;
		data_in	:	in		std_logic;
		found_it	:	out	std_logic
	);
	
end entity sequence_detector;

architecture fsm_arch of sequence_detector is

	type state_t is (IDLE, GOT_1, GOT_10);
	signal current_state	:	state_t	:= IDLE;
	signal next_state :	state_t	:= IDLE;

begin

	process_sync : process(clk, rst)
	begin
	
		if(rst = '1') then
			current_state <= IDLE;
			
		elsif rising_edge(clk) then
			current_state <= next_state;
			
		end if;
	end process process_sync;
	
	process_comb : process(current_state, data_in)
	begin
		
		found_it <= '0';
		
		case current_state is
		
			when IDLE =>
				if(data_in = '1') then
					next_state <= GOT_1;
				else
					next_state <= IDLE;
				end if;
				
			when GOT_1 =>
				if(data_in = '1') then
					next_state <= GOT_1;
				else
					next_state <= GOT_10;
				end if;
				
			when GOT_10 =>
				if(data_in = '1') then
					found_it <= '1';
					next_state <= GOT_1;
				else
					next_state <= IDLE;
				end if;
				
		end case;
		
	end process process_comb;
	
end architecture fsm_arch;
