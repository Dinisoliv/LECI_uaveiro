library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

--entity Bin2BCD is
	--port(dataIn    : in std_logic_vector(3 downto 0);
		  --unitsOut  : out std_logic_vector(3 downto 0);
		  --tenthsOut : out std_logic_vector(3 downto 0)); 
--end Bin2BCD;

--architecture Behavioral of Bin2BCD is

	--signal s_dataIn, s_dataOut : unsigned(4 downto 0);

--begin
	--s_dataIn <= "0" & unsigned(dataIn);
	--s_dataOut <= s_dataIn when (s_dataIn <= 9) else s_dataIn + 6;
	--unitsOut  <= std_logic_vector(s_dataOut(3 downto 0));
	--tenthsOut <= "000" & s_dataOut(4);
--end Behavioral;
		

entity Bin2BCD is
	port(dataIn_r    : in std_logic_vector(3 downto 0);
		  dataIn_m    : in std_logic_vector(3 downto 0);
		  unitsOut    : out std_logic_vector(3 downto 0);
		  tenthsOut   : out std_logic_vector(3 downto 0);
		  hundredsOut : out std_logic_vector(3 downto 0)); 
end Bin2BCD;

architecture Behavioral of Bin2BCD is

	signal s_dataIn      : unsigned(7 downto 0);
	signal s_unitsOut    : unsigned(7 downto 0);
	signal s_hundTen     : unsigned(7 downto 0);
	signal s_tenthsOut   : unsigned(7 downto 0);
	signal s_hundredsOut : unsigned(7 downto 0);

begin
	s_dataIn      <= unsigned(dataIn_m) & unsigned(dataIn_r);
	s_unitsOut    <= s_dataIn rem 10;
	s_hundTen     <= s_dataIn / 10;
	s_tenthsOut   <= s_hundTen rem 10;
	s_hundredsOut <= s_hundTen / 10;
	
	unitsOut    <= std_logic_vector(s_unitsOut(3 downto 0));
	tenthsOut   <= std_logic_vector(s_tenthsOut(3 downto 0));
	hundredsOut <= std_logic_vector(s_hundredsOut(3 downto 0));
end Behavioral;
		  