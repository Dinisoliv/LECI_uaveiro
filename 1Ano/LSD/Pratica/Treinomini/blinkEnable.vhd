library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity blinkEnable is
    Port (dataIn   : in std_logic_vector(3 downto 0);
          blinkGen : in std_logic;
          dataOut  : out std_logic_vector(3 downto 0));
end blinkEnable;

architecture Behavioral of blinkEnable is
begin
    process(blinkGen)
    begin
        if (blinkGen = '1') then
            dataOut <= dataIn;
        else
            dataOut <= (others => '0');
        end if;
    end process;
end Behavioral;
