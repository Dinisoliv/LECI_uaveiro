library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity RAM_1P_16_8 is
	port(writeCLk    : in std_logic;
		  writeEnable : in std_logic;
		  writeData   : in std_logic_vector(7 downto 0);
		  adress      : in std_logic_vector(3 downto 0);
		  readData    : out std_logic_vector(7 downto 0)); 
end RAM_1P_16_8;

architecture Behavioral of RAM_1P_16_8 is
	constant NUM_WORDS : integer := 16;
	subtype TDataWord is std_logic_vector(7 downto 0);
	type TMemory is array (0 to NUM_WORDS-1) of TDataWord;
	signal s_memory : TMemory;
begin
	process(writeClk)
	if (rising_edge(writeCLk)) then
		if (writeEnable = '1') then
			s_memory(to_integer(unsigned(adress))) <= writeData;
		end if;
	end if;	
	end process;
	
	readData <= s_memory(to_integer(unisgned(adress)));
end Behavioral;