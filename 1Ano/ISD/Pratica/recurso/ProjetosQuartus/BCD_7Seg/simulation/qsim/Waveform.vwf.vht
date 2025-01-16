-- Copyright (C) 2023  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "01/24/2024 14:26:23"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          BCD_7SegProj
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY BCD_7SegProj_vhd_vec_tst IS
END BCD_7SegProj_vhd_vec_tst;
ARCHITECTURE BCD_7SegProj_arch OF BCD_7SegProj_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a : STD_LOGIC;
SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL c : STD_LOGIC;
SIGNAL d : STD_LOGIC;
SIGNAL e : STD_LOGIC;
SIGNAL f : STD_LOGIC;
SIGNAL g : STD_LOGIC;
SIGNAL min : STD_LOGIC;
COMPONENT BCD_7SegProj
	PORT (
	a : OUT STD_LOGIC;
	B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	c : OUT STD_LOGIC;
	d : OUT STD_LOGIC;
	e : OUT STD_LOGIC;
	f : OUT STD_LOGIC;
	g : OUT STD_LOGIC;
	min : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : BCD_7SegProj
	PORT MAP (
-- list connections between master ports and signals
	a => a,
	B => B,
	c => c,
	d => d,
	e => e,
	f => f,
	g => g,
	min => min
	);
-- B[3]
t_prcs_B_3: PROCESS
BEGIN
	FOR i IN 1 TO 5
	LOOP
		B(3) <= '0';
		WAIT FOR 40000 ps;
		B(3) <= '1';
		WAIT FOR 40000 ps;
	END LOOP;
	B(3) <= '0';
WAIT;
END PROCESS t_prcs_B_3;
-- B[2]
t_prcs_B_2: PROCESS
BEGIN
	FOR i IN 1 TO 2
	LOOP
		B(2) <= '0';
		WAIT FOR 80000 ps;
		B(2) <= '1';
		WAIT FOR 80000 ps;
	END LOOP;
	B(2) <= '0';
WAIT;
END PROCESS t_prcs_B_2;
-- B[1]
t_prcs_B_1: PROCESS
BEGIN
	B(1) <= '0';
	WAIT FOR 160000 ps;
	B(1) <= '1';
	WAIT FOR 160000 ps;
	B(1) <= '0';
WAIT;
END PROCESS t_prcs_B_1;
-- B[0]
t_prcs_B_0: PROCESS
BEGIN
	B(0) <= '0';
	WAIT FOR 320000 ps;
	B(0) <= '1';
	WAIT FOR 80000 ps;
	B(0) <= '0';
WAIT;
END PROCESS t_prcs_B_0;
END BCD_7SegProj_arch;
