library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LedControler_Demo is    
    port(
        CLOCK_50 : in std_logic;
        SW       : in std_logic_vector(1 downto 0);
        LEDR     : out std_logic_vector(3 downto 0);
        LEDG     : out std_logic_vector(3 downto 0);
        HEX0     : out std_logic_vector(6 downto 0)
    );
end LedControler_Demo;

architecture Shell of LedControler_Demo is

    signal s_DecOut : std_logic_vector(3 downto 0);
    signal s_HexIn  : std_logic_vector(3 downto 0);
    
    signal s_blink1Hz : std_logic;
    signal s_blink2Hz : std_logic;
    signal s_clk5s    : std_logic;
    
    signal s_enable5s : std_logic;
    
begin

    s_HexIn <= std_logic_vector(unsigned("00" & SW(1 downto 0)) + 1);
    
    bin_7seg : entity work.Bin7SegDecoder(Behavioral)
                        port map(enable => '1',
                                 binInput => s_HexIn(3 downto 0),
                                 decOut_n => HEX0(6 downto 0));
    
    dec2_4 : entity work.DEc2_4En(Behavioral)
                        port map(enable  => '1',
                                 inputs  => SW(1 downto 0),
                                 outputs => s_DecOut(3 downto 0));
                                    
    blink_1hz : entity work.blink_gen(Behavioral)
                        generic map(NUMBER_STEPS => 50000000)
                        port map(clk   => CLOCK_50,
                                 reset => '0',
                                 blink => s_blink1Hz);
                                    
    blink_2hz : entity work.blink_gen(Behavioral)
                        generic map(NUMBER_STEPS => 25000000)
                        port map(clk   => CLOCK_50,
                                 reset => '0',
                                 blink => s_blink2Hz);
                                    
    clk_5s_period : entity work.ClkDivider(Behavioral)
                        generic map(divFactor => 250000000)
                        port map(ClkIn => CLOCK_50,
                                 ClkOut => s_clk5s);    
    
    process(s_DecOut)
    begin
        
        if (s_DecOut(0) = '1') then
            LEDR <= (others => '1');
            LEDG <= (others => '1');
        
        elsif (s_DecOut(1) = '1') then
            if (s_blink2Hz = '1') then
                LEDR <= (others => '1');
                LEDG <= (others => '0');
            else
                LEDR <= (others => '0');
                LEDG <= (others => '0');
            end if;
                
        elsif (s_DecOut(2) = '1') then
            if (s_blink1Hz = '1') then
                LEDR <= (others => '0');
                LEDG <= (others => '1');
            else
                LEDR <= (others => '0');
                LEDG <= (others => '0');
            end if;
                
        else
            if (rising_edge(s_clk5s)) then
                s_enable5s <= not s_enable5s;
            end if;
            if (s_enable5s = '1') then
                if (s_blink1Hz = '1') then
                    LEDR <= (others => '0');
                    LEDG <= (others => '1');
                else
                    LEDR <= (others => '0');
                    LEDG <= (others => '0');
                end if;
            else
                if (s_blink2Hz = '1') then
                    LEDR <= (others => '1');
                    LEDG <= (others => '0');
                else
                    LEDR <= (others => '0');
                    LEDG <= (others => '0');
                end if;
            end if;
        end if;
    end process;
end Shell;