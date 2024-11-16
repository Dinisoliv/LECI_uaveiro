library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder is
    port (
        SW    : in std_logic_vector(3 downto 0); 
        KEY   : in std_logic;
        HEX0  : out std_logic_vector(6 downto 0);
        LEDR  : out std_logic_vector(6 downto 0); 
        LEDG  : out std_logic_vector(3 downto 0)
    );
end Bin7SegDecoder;

architecture Behavioral of Bin7SegDecoder is
    signal internal_decOut : std_logic_vector(6 downto 0);
begin
    process(SW, KEY)
    begin
        if KEY = '1' then 
            case SW is 
                when "0001" =>
                    internal_decOut <= "1111001"; -- 1
                when "0010" =>
                    internal_decOut <= "0100100"; -- 2
                when "0011" =>
                    internal_decOut <= "0110000"; -- 3
                when "0100" =>
                    internal_decOut <= "0011001"; -- 4
                when "0101" =>
                    internal_decOut <= "0010010"; -- 5
                when "0110" =>
                    internal_decOut <= "0000010"; -- 6
                when "0111" =>
                    internal_decOut <= "1111000"; -- 7
                when "1000" =>
                    internal_decOut <= "0000000"; -- 8
                when "1001" =>
                    internal_decOut <= "0010000"; -- 9
                when "1010" =>
                    internal_decOut <= "0001000"; -- A
                when "1011" =>
                    internal_decOut <= "0000011"; -- b
                when "1100" =>
                    internal_decOut <= "1000110"; -- C
                when "1101" =>
                    internal_decOut <= "0100001"; -- d
                when "1110" =>
                    internal_decOut <= "0000110"; -- E
                when "1111" =>
                    internal_decOut <= "0001110"; -- F
                when others =>
                    internal_decOut <= "1000000"; -- 0
            end case;

            HEX0 <= internal_decOut;
            LEDR <= internal_decOut;
            LEDG <= "0000";
        else
            HEX0 <= "1111111";
            LEDR <= "1111111";
            LEDG <= "0000";
        end if;
    end process;
end Behavioral;
