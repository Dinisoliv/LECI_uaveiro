library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity CombShiftUnit is
	port(clk     : in std_logic;
		  dataIn  : in std_logic_vector(7 downto 0);
		  siLeft  : in std_logic;
		  siRight : in std_logic;
		  loadEn  : in std_logic;
		  rotate  : in std_logic;
		  dirLeft : in std_logic;
		  shArith : in std_logic;
		  dataOut : out std_logic_vector(7 downto 0));
end CombShiftUnit;

architecture Behavioral of CombShiftUnit is
	signal s_shiftReg : unsigned(7 downto 0);
begin
	process(clk)
	begin
	if (falling_edge(clk)) then
		if (loadEn = '1') then
			s_shiftReg <= unsigned(dataIn);
		elsif (rotate = '1') then
			if (dirLeft = '1') then
				s_shiftReg <= ROTATE_LEFT(s_shiftReg, 1);
			else
				s_shiftReg <= ROTATE_RIGHT(s_shiftReg, 1);
			end if;
		elsif (shArith = '1') then
			if (dirLeft = '1') then
				s_shiftReg <= SHIFT_LEFT(s_shiftReg, 1);
			else
				s_shiftReg <= SHIFT_RIGHT(s_shiftReg, 1);
			end if;
		elsif (dirLeft = '1') then
			s_shiftReg <= SHIFT_LEFT(s_shiftReg, 1);
		else
		 s_shiftReg <= SHIFT_RIGHT(s_shiftReg, 1);
		end if;
	end if;
end process;
dataOut <= std_logic_vector(s_shiftReg);
end Behavioral;

	--Deslocamentos lógicos
	--function SHIFT_LEFT (ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
	--function SHIFT_RIGHT (ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
	
	--Deslocamentos aritméticos
	--function SHIFT_LEFT (ARG: SIGNED; COUNT: NATURAL) return SIGNED;
	--function SHIFT_RIGHT (ARG: SIGNED; COUNT: NATURAL) return SIGNED;
	
	--Rotações
	--function ROTATE_LEFT (ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;
	--function ROTATE_RIGHT (ARG: UNSIGNED; COUNT: NATURAL) return UNSIGNED;