library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity AccN2 is
	generic (N : positive := 4);
	port(clk     : in std_logic;
		  enable  : in std_logic;
		  reset   : in std_logic;
		  dataIn  : in std_logic_vector(N-1 downto 0);
		  ovf     : out std_logic;
		  dataOut : out std_logic_vector(N-1 downto 0));
end AccN2;

architecture Behavioral of AccN2 is
	signal s_regOut   : unsigned(N downto 0);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then
				s_regOut <= (others => '0'); c 
			elsif (enable = '1') then
				s_regOut <= s_regOut + unsigned("0" & dataIn);
			end if;
		end if;
	end process;
	
	dataOut <= std_logic_vector(s_regOut(N-1 downto 0));
	ovf		<= s_regOut(N);
end Behavioral;
			
			