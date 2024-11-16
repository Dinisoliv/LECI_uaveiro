library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;		

entity Bin2BCD is
	port(dataIn_r    : in std_logic_vector(3 downto 0);
		  dataIn_m    : in std_logic_vector(3 downto 0);
		  negative    : out std_logic;
		  unitsOut    : out std_logic_vector(3 downto 0);
		  tenthsOut   : out std_logic_vector(3 downto 0);
		  hundredsOut : out std_logic_vector(3 downto 0));
end Bin2BCD;

architecture Behavioral of Bin2BCD is

	signal s_dataIn      : signed(7 downto 0);
	signal s_dataIn_r    : signed(3 downto 0);
	signal s_dataIn_m    : signed(3 downto 0);
	signal s_negative		: std_logic;
	signal s_absDataIn	: unsigned(7 downto 0);
	signal s_unitsOut    : unsigned(7 downto 0);
	signal s_hundTen     : unsigned(7 downto 0);
	signal s_tenthsOut   : unsigned(7 downto 0);
	signal s_hundredsOut : unsigned(7 downto 0);

begin
	s_dataIn_r    <= signed(dataIn_r);
	s_dataIn_m	  <= signed(dataIn_m);
	s_negative    <= '1' when (s_dataIn_r < 0) else
						  '1' when (s_dataIn_m < 0) else '0';
	
	s_dataIn      <= signed(dataIn_m & dataIn_r);
	s_absDataIn	  <= unsigned(s_dataIn) when (s_negative = '0') else unsigned(-s_dataIn);
	s_unitsOut    <= s_absDataIn rem 10;
	s_hundTen     <= s_absDataIn / 10;
	s_tenthsOut   <= s_hundTen rem 10;
	s_hundredsOut <= s_hundTen / 10;
	
	negative		<= s_negative;
	unitsOut    <= std_logic_vector(s_unitsOut(3 downto 0));
	tenthsOut   <= std_logic_vector(s_tenthsOut(3 downto 0));
	hundredsOut <= std_logic_vector(s_hundredsOut(3 downto 0));
end Behavioral;