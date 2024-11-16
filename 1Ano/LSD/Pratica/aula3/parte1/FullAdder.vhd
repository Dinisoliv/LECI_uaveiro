library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FullAdder is
	port(a, b ,Cin : in std_logic;
		  s, Cout   : out std_logic);
end FullAdder;

architecture Behavioral of FullAdder is
begin
	Cout <=  (a and b) or (a and Cin) or (b and Cin);
	s <= a xor b xor Cin;
end Behavioral;
	