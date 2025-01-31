--FILES FOR THE 4-1 MUX SAVED IN THE OUTPUT FILES!!!

library IEEE;
use ieee.std_logic_1164.all;

entity Mux4_1 is
	port(
		inputs: in std_logic_vector(3 downto 0);
		sel : in std_logic_vector(1 downto 0);
		output : out std_logic);
end Mux4_1;

architecture BehavProc of Mux4_1 is
begin
	process(sel, inputs)
	begin
		case sel is
			when "00" =>
				output <= inputs(0);
			when "01" =>
            output <= inputs(1);
         when "10" =>
				output <= inputs(2);
         when others =>
            output <= inputs(3);
      end case;	
	end process;
end BehavProc;