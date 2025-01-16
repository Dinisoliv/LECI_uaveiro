library ieee;
use ieee.std_logic_1164.all;

entity StallingUnit is
	port( RS : in std_logic_vector(4 downto 0);
		RT : in std_logic_vector(4 downto 0);
		RegWrite : in std_logic;
		ALUOp : in std_logic_vector(1 downto 0);
		Ex_RDD : in std_logic_vector(4 downto 0);
		IdEx_MemRead : in std_logic;
		Reset_IdEx : out std_logic;
		Enable_IfId : out std_logic;
		Enable_PC : out std_logic);
end StallingUnit;

architecture Behavioral of StallingUnit is
begin
	process(all)
	begin
		Enable_PC <= '1'; -- Normal flow
		Enable_IfId <= '1';
		Reset_IdEx <= '0';
		if(IdEx_MemRead = '1' and Ex_RDD /= "00000") then
			if(RegWrite = '1' and ALUOp = "10") then
				if(Ex_RDD = RS or Ex_RDD = RT) then
					Enable_PC <= '0'; -- Stall PC
					Enable_IfId <= '0'; -- Stall IF/ID
					Reset_IdEx <= '1'; -- Bubble in ID/EX
				end if;
			end if;
		end if;
	end process;
end Behavioral;