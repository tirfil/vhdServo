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

entity tb_SERVOTIMING is
end tb_SERVOTIMING;

architecture stimulus of tb_SERVOTIMING is

-- COMPONENTS --
	component SERVOTIMING
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			S1MS		: in	std_logic;
			SBIT		: in	std_logic;
			SBIT_DLY	: out	std_logic;
			LDDATA		: out	std_logic;
			START		: out	std_logic;
			MODE		: out	std_logic_vector(1 downto 0)
		);
	end component;

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
	signal SBIT_DLY		: std_logic;
	signal LDDATA		: std_logic;
	signal START		: std_logic;
	signal MODE		: std_logic_vector(1 downto 0);

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_SERVOTIMING_0 : SERVOTIMING
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			S1MS		=> S1MS,
			SBIT		=> SBIT,
			SBIT_DLY	=> SBIT_DLY,
			LDDATA		=> LDDATA,
			START		=> START,
			MODE		=> MODE
		);

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
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		wait until (S1MS'event and S1MS = '0');
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
