library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DrinksMachine is
	port(CLOCK_50 : in std_logic;
		  KEY      : in std_logic_vector(0 downto 0);
		  SW       : in std_logic_vector(1 downto 0);
		  LEDR     : out std_logic_vector(7 downto 0);
		  LEDG     : out std_logic_vector(0 downto 0));
end DrinksMachine;

architecture Shell of DrinksMachine is
	
	signal s_clk1Hz : std_logic;
	signal s_DebV, s_DebC : std_logic;
	
begin
	
	clk_1Hz: entity work.ClkDivider(Behavioral)
					generic map(divFactor => 50000000)
					port map(ClkIn  => CLOCK_50,
								ClkOut => s_clk1Hz);
	
	LEDR(0) <= s_clk1Hz;
	LEDR(1) <= '0';
	
	debounce_V: entity work.DebounceUnit(Behavioral)
							generic map(kHzClkFreq		=> 50000,
											mSecMinInWidth	=> 100,
											inPolarity		=> '1',
											outPolarity		=> '1')
							port map(refClk    => CLOCK_50,
										dirtyIn	 => SW(0),		
										pulsedOut => s_DebV);
	
	debounce_C: entity work.DebounceUnit(Behavioral)
							generic map(kHzClkFreq		=> 50000,
											mSecMinInWidth	=> 100,
											inPolarity		=> '1',
											outPolarity		=> '1')
							port map(refClk    => CLOCK_50,
										dirtyIn	 => SW(1),		
										pulsedOut => s_DebC);
	
	drink_machine: entity work.DrinksFSM(Behavioral)
					port map(clk    => CLOCK_50,
								reset  => not KEY(0),
								V      => s_DebV,
								C      => s_DebC,
								Drink  => LEDG(0),
								State(0) => LEDR(2),
								State(1) => LEDR(3),
								State(2) => LEDR(4),
								State(3) => LEDR(5),
								State(4) => LEDR(6),
								State(5) => LEDR(7));
end Shell;
	
	