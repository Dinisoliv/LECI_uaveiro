library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LatchDemo is
	port(SW : in std_logic_vector(0 downto 0);
		  KEY :  in std_logic_vector(0 downto 0);
		  LEDR : out std_logic_vector(0 downto 0));
end LatchDemo;
		  
architecture Shell of LatchDemo is
begin
	ff_d : entity work.LatchD(Behavioral)
	port map(enable => KEY(0),
				dataIn => SW(0),
				dataOut => LEDR(0));
end Shell;