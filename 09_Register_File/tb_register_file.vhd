library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_register_file is
end entity tb_register_file;

architecture test of tb_register_file is

	component register_file is

		port(
		
			--main control signals
			clk				: in std_logic;
			rst				: in std_logic;
			Write_Enable	: in std_logic;
			
			--write port		
			Addr_Write	: in std_logic_vector(3 downto 0);
			Data_In		: in std_logic_vector(3 downto 0);
			
			--read port A
			Addr_Read_A	: in std_logic_vector(3 downto 0);
			Data_Out_A	: out	std_logic_vector(3 downto 0);
			
			--read port B
			Addr_Read_B	: in std_logic_vector(3 downto 0);
			Data_Out_B	: out std_logic_vector(3 downto 0)
			
		);

	end component register_file;
	
	constant CLK_PERIOD	: time := 20 ns;
	
	--input signals
	signal s_clk				: std_logic := '0';
	signal s_rst				: std_logic := '0';
	signal s_Write_Enable	: std_logic := '0';
			
	signal s_Addr_Write	: std_logic_vector(3 downto 0) := (others => '0');
	signal s_Data_In		: std_logic_vector(3 downto 0) := (others => '0');
	
	signal s_Addr_Read_A	: std_logic_vector(3 downto 0) := (others => '0');
	signal s_Addr_Read_B	: std_logic_vector(3 downto 0) := (others => '0');
	
	--output signals
	signal s_Data_Out_A	: std_logic_vector(3 downto 0);
	signal s_Data_Out_B	: std_logic_vector(3 downto 0);

begin

	UUT	: register_file
		port map(
		
			clk				=> s_clk,
			rst				=> s_rst,
			Write_Enable	=> s_Write_Enable,
			Addr_Write		=> s_Addr_Write,
			Data_In			=> s_Data_In,
			Addr_Read_A		=> s_Addr_Read_A,
			Data_Out_A		=> s_Data_Out_A,
			Addr_Read_B		=> s_Addr_Read_B,
			Data_Out_B		=> s_Data_Out_B
			
		);
		
	clk_process	: process
	begin
		
		s_clk <= '0';
		wait for CLK_PERIOD / 2;
		s_clk <= '1';
		wait for CLK_PERIOD / 2;
		
	end process clk_process;
	
	stim_process	: process
	begin
	
		s_rst <= '1';
		s_Write_Enable <= '0';
		wait for 30 ns;
		
		s_rst <= '0';
		s_Write_Enable <= '1';
		
		s_Addr_Write <= "0001";
		s_Data_In 	 <= "0101";
		wait for CLK_PERIOD;
		
		s_Addr_Write <= "0010";
		s_Data_In 	 <= "1010";
		wait for CLK_PERIOD;
		
		s_Write_Enable <= '0';
		s_Data_In		<= "1111";
		
		s_Addr_Read_A 	<= "0001";
		s_Addr_Read_B	<= "0010";
		
		wait for CLK_PERIOD;
		
		s_Addr_Read_A 	<= "0010";
		s_Addr_Read_B	<= "0000";
		
		wait for CLK_PERIOD;
		
		wait;
		
	end process stim_process;

end architecture test;