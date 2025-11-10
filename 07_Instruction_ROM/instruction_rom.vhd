library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_rom is

	port(
		clk		: in std_logic;
		Address	: in std_logic_vector(3 downto 0);
		
		Data_Out	: out std_logic_vector(1 downto 0)
	);

end entity instruction_rom;

architecture bhv of instruction_rom is

	type rom_array_t is array(0 to 15) of std_logic_vector(1 downto 0);
	
	constant MY_PROGRAM : rom_array_t := (
		0 => "00",
		1 => "01",
		2 => "10",
		3 => "11",
		4 => "00",
		5 => "01",
		
		others => "00"
	);

begin

	read_rom_process : process(clk)
	
	variable address_index : integer;
	
	begin

		if rising_edge(clk) then
		
			address_index := to_integer(unsigned(Address));
			
			Data_Out <= MY_PROGRAM(address_index);
			
		end if;
		
	end process read_rom_process;

end architecture bhv;