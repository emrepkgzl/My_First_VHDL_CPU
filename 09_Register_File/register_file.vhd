library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is

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

end entity register_file;

architecture bhv of register_file is

	type register_array_t is array (0 to 15) of std_logic_vector(3 downto 0);
	signal register_bank	: register_array_t := (others => (others => '0'));

begin

	write_process	: process(clk, rst)
	
	variable write_index	: integer;
	
	begin
	
		if(rst = '1') then
		
			register_bank <= (others => (others => '0'));
			
		elsif rising_edge(clk) then
		
			if(Write_Enable = '1') then
			
				write_index := to_integer(unsigned(Addr_Write));
				register_bank(write_index) <= Data_In;
				
			end if;
			
		end if;
		
	end process write_process;
	
	Data_Out_A <= register_bank(to_integer(unsigned(Addr_Read_A)));
	
	Data_Out_B <= register_bank(to_integer(unsigned(Addr_Read_B)));
			
end architecture bhv;