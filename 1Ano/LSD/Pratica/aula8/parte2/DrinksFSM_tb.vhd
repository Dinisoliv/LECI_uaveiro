library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DrinksFSM_tb is

end DrinksFSM_tb;

architecture Stimulus of DrinksFSM_tb is

	signal s_clk, s_InpClk, s_reset, s_V, s_C, s_Drink : std_logic;

begin

	uut : entity work.DrinksFSM(Behavioral)
				port map(clk    => s_clk,
							InpClk => s_InpClk,
							reset  => s_reset,
							V      => s_V,
							C      => s_C,
							Drink  => s_Drink);
	
	clk_proc : process
	begin
		s_clk <= '0';
		wait for 100 ns;
		s_clk <= '1';
		wait for 100 ns;
	end process;
	
	InpClk_proc : process
	begin
		s_InpClk <= '0';
		wait for 100 ns;
		s_InpClk <= '1';
		wait for 100 ns;
	end process;
	
	stim_proc : process
	begin
		s_reset <= '1';
		s_V <= '0';
		s_C <= '0';
		wait for 100 ns;
		s_reset <= '0';
		s_V <= '1';
		--5 ciclos
		wait for 100 ns;
		s_V <= '0';
		s_C <= '1';
		--2 ciclos
		wait for 100 ns;
		s_V <= '1';
		s_C <= '0';
		--1 ciclo
		wait for 100 ns;
		s_V <= '0';
		s_C <= '1';
		--3 ciclo
		wait for 100 ns;
		s_V <= '1';
		s_C <= '0';
		--2 ciclo
		wait for 100 ns;
		s_V <= '1';
		s_C <= '0';
		--3 ciclo
		wait for 100 ns;
		s_V <= '0';
		s_C <= '1';
		--1 ciclo
		wait for 100 ns;
	end process;
end Stimulus;