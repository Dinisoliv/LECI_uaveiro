library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Penc4_2 is
	port(decodedIn  :  in std_logic_vector(3 downto 0);
		  encodedOut :  out std_logic_vector(1 downto 0);
		  validOut   :  out std_logic);
end Penc4_2;

architecture Behavioral of Penc4_2 is
begin
		process(decodedIn)
		begin
				if decodedIn(3) = '1' then
					encodedOut <= "11";
					validOut <= '1';
				elsif decodedIn(2) = '1' then
					encodedOut <= "10";
					validOut <= '1';
				elsif decodedIn(1) = '1' then
					encodedOut <= "01";
					validOut <= '1';
				elsif decodedIn(0) = '1' then
					encodedOut <= "00";
					validOut <= '1';
				else
					encodedOut <= "--";
					validOut <= '0';
				end if;
		end process;
end Behavioral;