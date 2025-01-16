library ieee;
use ieee.std_logic_1164.all;

entity ForwardingUnit is
	port(ExMem_RegWrite : in std_logic;
		ExMem_WrEn		: in std_logic;
		MemWb_RegWrite  : in std_logic;
		IfId_branch		: in std_logic;
		IfId_RS			: in std_logic_vector(4 downto 0);
		IfId_RT			: in std_logic_vector(4 downto 0);
		IdEx_RS 		: in std_logic_vector(4 downto 0);
		IdEx_RT   		: in std_logic_vector(4 downto 0);
		ExMem_RDD 		: in std_logic_vector(4 downto 0);
		ExMem_RT		: in std_logic_vector(4 downto 0);
		MemWb_RDD 		: in std_logic_vector(4 downto 0);
		Forw_EX_A 		: out std_logic_vector(1 downto 0);
		Forw_EX_B 		: out std_logic_vector(1 downto 0));
		Forw_ID_A 		: out std_logic;
		Forw_ID_B 		: out std_logic;
		Forw_Mem 		: out std_logic;
end ForwardingUnit;

architecture Behavioral of ForwardingUnit is
begin
	process(all)
	begin
		Forw_EX_A <= "00"; -- no hazard
		Forw_EX_B <= "00"; -- no hazard
		Forw_ID_A <= '0'; -- no hazard
		Forw_ID_B <= '0'; -- no hazard
		Forw_Mem <= '0'; -- no hazard
		
		if(MemWb_RegWrite = '1' and MemWb_RDD /= "00000")then
			if(MemWb_RDD = IdEx_RS) then Forw_EX_A <= "01";end if;
			if(MemWb_RDD = IdEx_RT) then Forw_EX_B <= "01";end if;
		end if;
		if(ExMem_RegWrite = '1' and ExMem_RDD /= "00000")then
			if(ExMem_RDD = IdEx_RS) then Forw_EX_A <= "10";end if;
			if(ExMem_RDD = IdEx_RT) then Forw_EX_B <= "10";end if;
		end if;
		
		if(IfId_branch = '1')then 
			if(ExMem_RDD = IfId_RT) then Forw_ID_A <= '1'; end if;
			if(ExMem_RDD = IfId_RS) then Forw_ID_B <= '1'; end if;
		end if;
		
		if(ExMem_WrEn = '1')
			if(ExMem_RT = MemWb_RDD) then Forw_Mem <= '1'; end if;
		end if;
		
	end process;
end Behavioral;