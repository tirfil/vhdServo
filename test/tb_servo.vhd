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

entity tb_SERVO is
end tb_SERVO;

architecture stimulus of tb_SERVO is

-- COMPONENTS --
	component SERVO
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			DATA		: in	std_logic_vector(7 downto 0);
			SERVO		: out	std_logic
		);
	end component;

--
-- SIGNALS --
	signal MCLK		: std_logic;
	signal nRST		: std_logic;
	signal DATA		: std_logic_vector(7 downto 0);
	signal SERVO1		: std_logic;

--
	signal RUNNING	: std_logic := '1';

begin

-- PORT MAP --
	I_SERVO_0 : SERVO
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			DATA		=> DATA,
			SERVO		=> SERVO1
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
		DATA <= X"7F";
		wait for 1000 ns;
		nRST <= '1';
		wait for 20 ms;
		DATA <= X"FF";
		wait for 20 ms;
		DATA <= X"00";
		wait for 20 ms;
		DATA <= X"FE";
		wait for 20 ms;
		DATA <= X"01";
		wait for 20 ms;
		RUNNING <= '0';
		wait;
	end process GO;

end stimulus;
