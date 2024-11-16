library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Debouncer is
	generic(N : positive := 8)
	port(clk       : in std_logic;
		 dirtyln_n : in std_logic;
		 cleanOut  : out std_logic);
end Debouncer;

architecture Behavioral of Debouncer is
	signal s_FFout : std_logic_vector(N downto 0);
begin
	s_FFout(0) <= '1';
	
	process(dirtyln_n, clk)
	begin
		if (dirtyln_n = '1') then
			s_FFout(N downto 1) <= others => '0';
		
		elsif (rising_edge(clk)) then
			s_FFout(N downto 1) <= s_FFout(N-1 downto 0);
		end if;
	end process;

	cleanOut <= s_FFout(N);

end Behavioral;
		 