library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin2BCD is
	port(dataIn    : in std_logic_vector(3 downto 0);
		  unitsOut  : out std_logic_vector(3 downto 0);
		  tenthsOut : out std_logic_vector(3 downto 0)); 
end Bin2BCD;

architecture Behavioral of Bin2BCD is

	signal s_dataIn, s_dataOut : unsigned(4 downto 0);

begin
	s_dataIn <= "0" & unsigned(dataIn);
	s_dataOut <= s_dataIn when (s_dataIn <= 9) else s_dataIn + 6;
	unitsOut  <= std_logic_vector(s_dataOut(3 downto 0));
	tenthsOut <= "000" & s_dataOut(4);
end Behavioral;