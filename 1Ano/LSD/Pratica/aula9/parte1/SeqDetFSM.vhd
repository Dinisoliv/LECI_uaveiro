library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity SeqDetFSM is
	port(reset : in std_logic;
		  clk   : in std_logic;
		  xIn   : in std_logic;
		  stout : out std_logic_vector(3 downto 0);
		  zOut  : out std_logic);
end SeqDetFSM;

architecture Behavioral of SeqDetFSM is
	type state is (A, B, C, D);
	signal PS, NS : state := A;
begin
	sync_proc: process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				PS <= A;
			else 
				PS <= NS;
			end if;
		end if;
	end process;
	
	MealyArch: process(PS, xIn)
	begin
		zOut <= '0';
		case PS is
			when A =>
				if (xIn = '1') then
					NS <= B;
				else 
					NS <= A;
				end if;
			when B =>
				if (xIn = '1') then
					NS <= B;
				else
					NS <= C;
				end if;
			when C =>
				if (xIn = '1') then
					NS <= B;
				else
					NS <= D;
				end if;
			when D =>
				if (xIn = '1') then
					NS <= B;
					zOut <= '1';
				else
					NS <= A;
				end if;
			when others =>
				NS <= A;
		end case;
	end process;
	
	with PS select
		stOut <= "0001" when A,
					"0010" when B,
					"0100" when C,
					"1000" when D,
					"0000" when others;
end Behavioral;
	  