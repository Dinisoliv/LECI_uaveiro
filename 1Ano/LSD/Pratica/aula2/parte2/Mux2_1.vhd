library IEEE;
use ieee.std_logic_1164.all;

entity Mux2_1 is
	port(
		input0 : in std_logic;
		input1 : in std_logic;
		sel : in std_logic;
		output : out std_logic);
end Mux2_1;

architecture BehavProc of Mux2_1 is
begin
	process(sel, input0, input1)
	begin
		if (sel = '0') then
			output <= input0;
		elsif (sel = '1') then
			output <= input1;
		else
			output <= '0';
		end if;
	end process;
end BehavProc;