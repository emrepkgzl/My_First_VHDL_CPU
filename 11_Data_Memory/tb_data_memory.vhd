library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_data_memory is
end entity tb_data_memory;

architecture bhv of tb_data_memory is

	component data_memory is

		port(
			
			clk				: in std_logic;
			Write_Enable	: in std_logic;
			Address			: in std_logic_vector(3 downto 0);
			
			Data_In			: in std_logic_vector(3 downto 0);
			Data_Out			: out std_logic_vector(3 downto 0)
			
		);

	end component data_memory;
	
	signal s_clk				:	std_logic := '0';
	signal s_write_en	:	std_logic := '0';
	signal s_address			:	std_logic_vector(3 downto 0) := (others => '0');
	
	signal s_data_in			:	std_logic_vector(3 downto 0) := (others => '0');
	signal s_data_out			:	std_logic_vector(3 downto 0);
	
	signal sim_done: boolean := false;
	
	constant CLK_PERIOD		: time	:= 20 ns;

begin

	UUT	: data_memory
	
		port map(
			
			clk				=> s_clk,
			Write_Enable	=> s_write_en,
			Address			=> s_address,
			Data_In			=> s_data_in,
			Data_Out			=> s_data_out			
			
		);
		
		clk_process	: process
		begin
		
			while not sim_done loop
		
				s_clk <= '0';
				wait for CLK_PERIOD / 2;
				
				s_clk <= '1';
				wait for CLK_PERIOD / 2;
				
			end loop;
			wait;
			
		end process;
		
		stim_process	: process
		begin
		
			wait for CLK_PERIOD;
			
			s_address	<= "0011";
			s_data_in	<= "1010";
			s_write_en	<= '1';
			
			wait for CLK_PERIOD;
			
			s_address	<= "0100";
			s_data_in	<= "0001";
			
			wait for CLK_PERIOD;
			
			s_address	<= "0101";
			s_data_in	<= "1110";
			s_write_en	<= '0';
			
			wait for CLK_PERIOD;
			
			s_address	<= "0011";
			
			wait for CLK_PERIOD;
			
			s_address	<= "0100";
			
			wait for CLK_PERIOD;
			
			s_address	<= "0101";
			
			wait for CLK_PERIOD;
			
			sim_done <= true;
			wait;
		
		end process stim_process;

end architecture bhv;