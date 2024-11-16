library IEEE;
use IEEE.std_logic_1164.all;

entity FlipFlopD2 is
	port (clk : in std_logic;
			d   : in std_logic;
			set : in std_logic;
			rst : in std_logic;
			q   : out std_logic);
end FlipFlopD2;
			
architecture Behavioral of FlipFlopD2 is
begin
	process(clk, rst, set)
	begin
		if (rst = '1') then
				q <= '0';
		elsif (set = '1') then
				q <= '1';         
		elsif (rising_edge(clk)) then
				q <= d;
		end if;
	end process;
end Behavioral;