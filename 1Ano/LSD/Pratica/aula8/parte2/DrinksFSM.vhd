library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DrinksFSM is
	port(clk    : in std_logic;
		  reset  : in std_logic;
		  V      : in std_logic;
		  C      : in std_logic;
		  Drink  : out std_logic;
		  State  : out std_logic_vector(5 downto 0));
end DrinksFSM;

architecture Behavioral of DrinksFSM is

	type TState is (START, S1, S2, S3, S4, FINISH);
	signal pState, nState: TState := START;
	signal V_sync, C_sync : std_logic;

begin

	sync_proc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				pState <= START;
			else
				pState <= nState;
			end if;
		end if;
	end process;

	comb_process: process(pState, V, C)
	begin
		Drink <= '0';
		nState <= pState;
		case pState is
		when START => 
			if (V = '1') then
				nState <= S1;
			elsif (C = '1') then
				nState <= S3;
			end if;
			State <= "000001";
			
		when S1 =>
			if (V = '1') then
				nState <= S2;
			elsif (C = '1') then
				nState <= s4;
			end if;
			State <= "000010";
			
		when S2 =>
			if (V = '1') then
				nState <= S3;
			elsif (C = '1') then
				nState <= FINISH;
			end if;
			State <= "000100";
			
		when S3 =>
			if (V = '1') then
				nState <= S4;
			elsif (C = '1') then
				nState <= FINISH;
			end if;
			State <= "001000";
			
		when S4 =>
			if (V= '1') then
				nState <= FINISH;
			elsif (C = '1') then
				nState <= FINISH;
			end if;
			State <= "010000";
		
		when FINISH =>
			Drink  <= '1';
			nState <= START;
			State <= "100000";
		
		end case;
	end process;
		
end Behavioral;