library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is

	port(
		
		clk				: in std_logic;
		Write_Enable	: in std_logic;
		Address			: in std_logic_vector(3 downto 0);
		
		Data_In			: in std_logic_vector(3 downto 0);
		Data_Out			: out std_logic_vector(3 downto 0)
		
	);

end entity data_memory;

architecture bhv of data_memory is

	type ram_array_t is array(0 to 15) of std_logic_vector(3 downto 0);

	signal RAM : ram_array_t := (others => (others => '0'));

begin

	write_process	: process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(Write_Enable = '1') then
			
				RAM(to_integer(unsigned(Address))) <= Data_In;
				
			end if;
		end if;
		
	end process write_process;
	
	Data_Out <= RAM(to_integer(unsigned(Address)));
	
end architecture bhv;