library ieee;
use ieee.std_logic_1164.all;

entity tb_instruction_rom is
end entity tb_instruction_rom;

architecture test of tb_instruction_rom is

	component instruction_rom is

		port(
			clk		: in std_logic;
			Address	: in std_logic_vector(3 downto 0);
			
			Data_Out	: out std_logic_vector(1 downto 0)
		);

	end component instruction_rom;
	
	constant CLK_PERIOD : time := 20 ns;
	
	signal s_clk		: std_logic := '0';
	signal s_Address	: std_logic_vector(3 downto 0) := (others => '0');
	
	signal s_Data_Out	: std_logic_vector(1 downto 0);

begin

	UUT : instruction_rom
		port map(
			clk		=> s_clk,
			Address	=> s_Address,
			Data_Out => s_Data_Out
		);
		
	clk_process : process
	begin
	
		s_clk <= '1';
		wait for CLK_PERIOD / 2;
		s_clk <= '0';
		wait for CLK_PERIOD / 2;
		
	end process clk_process;
	
	stim_process : process
	begin
	
		s_Address <= "0000";
		wait for CLK_PERIOD;
		
		s_Address <= "0001";
		wait for CLK_PERIOD;
		
		s_Address <= "0010";
		wait for CLK_PERIOD;
		
		s_Address <= "0011";
		wait for CLK_PERIOD;
		
		s_Address <= "0001";
		wait for CLK_PERIOD;
		
		s_Address <= "0110";
		wait for CLK_PERIOD;
		
		wait;
		
	end process stim_process;

end architecture test;