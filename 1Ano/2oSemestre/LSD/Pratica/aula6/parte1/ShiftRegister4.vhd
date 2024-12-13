library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftRegister4 is
	port(clk : in std_logic;
		  sin : in std_logic;
		  dataOut : out std_logic_vector(3 downto 0));
end ShiftRegister4;

architecture Behavioral of ShiftRegister4 is
	signal s_outFF1 : std_logic;
	signal s_outFF2 : std_logic;
	signal s_outFF3 : std_logic;
	signal s_outFF4 : std_logic;
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
				s_outFF1 <= sin;
				s_outFF2 <= s_outFF1;
				s_outFF3 <= s_outFF2;
				s_outFF4 <= s_outFF3;
		end if;
	end process;
dataOut <= (s_outFF1 & s_outFF2 & s_outFF3 & s_outFF4);
end Behavioral;