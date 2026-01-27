library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_rom is

	port(
		clk		: in std_logic;
		Enable 	: in std_logic;
		Address	: in std_logic_vector(3 downto 0);
		
		Data_Out	: out std_logic_vector(15 downto 0)
	);

end entity instruction_rom;

architecture bhv of instruction_rom is

	type rom_array_t is array(0 to 15) of std_logic_vector(15 downto 0);
	
	-- R-Type:	[OpCode(4)] [Target(4)] [Source A(4)] [Source B(4)]
	-- I-Type:	[OpCode(4)] [Target(4)] [NULL(4)]     [Immidiate Value(4)]
	
	constant MY_PROGRAM : rom_array_t := (
	
		--test instructions start
		--0 => "1000" & "0001" & "0000" & "0101", -- LDI R1, 5
		--1 => "1000" & "0010" & "0000" & "0111", -- LDI R2, 7
		--2 => "0000" & "0011" & "0001" & "0010", -- ADD R3, R1, R2
		--3 => "0001" & "0100" & "0001" & "0010", -- SUB R4, R1, R2
		--4 => "0010" & "0101" & "0001" & "0010", -- AND R5, R1, R2
		--5 => "0011" & "0110" & "0001" & "0010", -- OR  R6, R1, R2
		--test instructions end
		
		
		0	=> "1000" & "0001" & "0000" & "0101", -- LDI	 R1,  5
		1	=> "1000" & "0010" & "0000" & "0111", -- LDI  R2,  7
		2	=> "1001" & "0111" & "0001" & "0010", -- BEQ  A7,  R1, R2
		3	=> "0001" & "0011" & "0010" & "0001", -- SUB  R3,  R2, R1
		4	=> "0000" & "0100" & "0001" & "0011", -- ADD  R4,  R1, R3
		5	=> "1001" & "1000" & "0010" & "0100", -- BEQ  A8,  R2, R4
		6	=> "0000" & "0011" & "0001" & "0010", -- ADD  R3,  R1, R2
		7	=> "0010" & "0011" & "0001" & "0010", -- AND  R3,  R1, R2
		8	=> "0001" & "0100" & "0001" & "0010", -- SUB  R4,  R1, R2
		9	=> "0010" & "0101" & "0001" & "0010", -- AND  R5,  R1, R2
		10	=> "0011" & "0110" & "0001" & "0010", -- OR   R6,  R1, R2
		11	=>	"0100" & "0111" & "0001" & "0010", -- XOR  R7,  R1, R2
		12	=>	"0101" & "1000" & "0001" & "0010", -- NAND R8,  R1, R2
		13	=>	"1101" & "0000" & "0111" & "1000", -- STR  R8, &R7
		14	=> "1000" & "1000" & "0000" & "0000", -- LDI  R8,  0
		15	=>	"1100" & "1000" & "0111" & "0000", -- LDR  R8, &R7
		
		
		
		others => "1111" & "0000" & "0000" & "0000" -- NOP
	);

begin

	read_rom_process : process(clk)
	
	variable address_index : integer;
	
	begin

		if rising_edge(clk) then
		
			if(Enable = '1') then
		
				address_index := to_integer(unsigned(Address));
				
				Data_Out <= MY_PROGRAM(address_index);
				
			end if;
			
		end if;
		
	end process read_rom_process;

end architecture bhv;