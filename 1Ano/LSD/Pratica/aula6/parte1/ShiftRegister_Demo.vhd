library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftRegister_Demo is
	port(CLOCK_50 : in std_logic;
		  SW : in std_logic_vector(11 downto 0);
		  LEDR : out std_logic_vector(7 downto 0));
end ShiftRegister_Demo;

architecture Shell of ShiftRegister_Demo is
	signal s_clock : std_logic;
begin
	system_core : entity work.ShiftRegisterLoadN(Behavioral)
		generic map (N => 8)
		port map(clk     => s_clock,
					sin     => SW(0),
					enable  => SW(3),
					load    => SW(2),
					reset   => SW(1),
					dataIn  => SW(11 downto 4),
					dataOut => LEDR(7 downto 0));
					
	clock_div : entity work.ClkDividerN(Behavioral)
		generic map(divFactor => 50_000_000)
		port map(clkIn => CLOCK_50,
					clkOut => s_clock);
end Shell;
	
	