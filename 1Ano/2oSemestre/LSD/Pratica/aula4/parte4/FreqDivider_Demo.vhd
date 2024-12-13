library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FreqDivider_Demo is
    port (CLOCK_50 : in std_logic;
			 SW       : in std_logic_vector(1 downto 0);
			 KEY      : in std_logic_vector(0 downto 0);
          HEX0     : out std_logic_vector(6 downto 0));
end FreqDivider_Demo;

architecture Shell of FreqDivider_Demo is
	signal s_clkOut : std_logic;
	signal s_count  : std_logic_vector(3 downto 0); 
begin
	clk_div : entity work.FreqDivider(Behavioral)
        port map (clkIn  => CLOCK_50,
						k      => x"05F5E100", --explain this value
						clkOut => s_clkOut);
						
	system_core : entity work.CounterUpDown4(Behavioral)
		port map(clk    => s_clkOut,
					upDown => SW(1),
					reset  => SW(0),
					count  => s_count);
					
	Bin7SegDec : entity work.Bin7SegDecoder(Behavioral)
		port map(binInput => s_count,
					enable   => KEY(0),
					decOut_n => HEX0(6 downto 0));
end Shell;