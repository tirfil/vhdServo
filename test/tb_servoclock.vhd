--###############################
--# Project Name : 
--# File         : 
--# Author       : 
--# Description  : 
--# Modification History
--#
--###############################

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_SERVOCLOCK is
end tb_SERVOCLOCK;

architecture stimulus of tb_SERVOCLOCK is

-- COMPONENTS --
	component SERVOCLOCK
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			S1MS		: out	std_logic;
			SBIT		: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal nRST		: std_logic;
	signal S1MS		: std_logic;
	signal SBIT		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_SERVOCLOCK_0 : SERVOCLOCK
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			S1MS		=> S1MS,
			SBIT		=> SBIT
		);

--
	CLOCK: process
	begin
		while (RUNNING = '1') loop
			MCLK <= '1';
			wait for 10 ns;
			MCLK <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process CLOCK;

	GO: process
	begin
		nRST <= '0';
		wait for 1000 ns;
		nRST <='1';
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');

		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
