library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Penc16_4 is
	port(decodedIn  :  in std_logic_vector(15 downto 0);
		  encodedOut :  out std_logic_vector(3 downto 0);
		  validOut   :  out std_logic);
end Penc16_4;

architecture Behavioral of Penc16_4 is
begin
		process(decodedIn)
		begin
				if decodedIn(15) = '1' then
					encodedOut <= "1111";
					validOut <= '1';
				elsif decodedIn(14) = '1' then
					encodedOut <= "1110";
					validOut <= '1';
				elsif decodedIn(13) = '1' then
					encodedOut <= "1101";
					validOut <= '1';
				elsif decodedIn(12) = '1' then
					encodedOut <= "1100";
					validOut <= '1';
				elsif decodedIn(11) = '1' then
					encodedOut <= "1011";
					validOut <= '1';
				elsif decodedIn(10) = '1' then
					encodedOut <= "1010";
					validOut <= '1';
				elsif decodedIn(9) = '1' then
					encodedOut <= "1001";
					validOut <= '1';
				elsif decodedIn(8) = '1' then
					encodedOut <= "1000";
					validOut <= '1';
				elsif decodedIn(7) = '1' then
					encodedOut <= "0111";
					validOut <= '1';
				elsif decodedIn(6) = '1' then
					encodedOut <= "0110";
					validOut <= '1';				
				elsif decodedIn(5) = '1' then
					encodedOut <= "0101";
					validOut <= '1';
				elsif decodedIn(4) = '1' then
					encodedOut <= "0100";
					validOut <= '1';
				elsif decodedIn(3) = '1' then
					encodedOut <= "0011";
					validOut <= '1';
				elsif decodedIn(2) = '1' then
					encodedOut <= "0010";
					validOut <= '1';
				elsif decodedIn(1) = '1' then
					encodedOut <= "0001";
					validOut <= '1';
				elsif decodedIn(0) = '1' then
					encodedOut <= "0000";
					validOut <= '1';
				else
					encodedOut <= "----";
					validOut <= '0';
				end if;
		end process;
end Behavioral;