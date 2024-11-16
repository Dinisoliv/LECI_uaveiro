library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetector is
	port(CLOCK_50 : in std_logic;
		  SW       : in std_logic_vector(0 downto 0);
		  LEDG     : out std_logic_vector(3 downto 0);
		  LEDR     : out std_logic_vector(0 downto 0));
end SeqDetector;

architecture Shell of SeqDetector is
	signal s_clkdiv : std_logic;
begin
	clk_div: entity work.ClkDivider(Behavioral)
					generic map(divFactor => 250000000)
					port map(clkIn  => CLOCK_50,
								clkOut => s_clkDiv);
								
	seg_detect: entity work.SeqDetFSM(Behavioral)
					port map(clk   => s_clkDiv,
								reset => '0',
								xIn   => SW(0),
								stout => LEDG(3 downto 0),
								zOut  => LEDR(0));
end Shell;