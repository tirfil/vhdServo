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

entity SERVO is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		DATA		: in	std_logic_vector(7 downto 0);
		SERVO		: out	std_logic
	);
end SERVO;

architecture struct of SERVO is
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

	component SERVOUNIT
		port(
			MCLK		: in	std_logic;
			nRST		: in	std_logic;
			LDDATA		: in	std_logic;
			START		: in	std_logic;
			MODE		: in	std_logic_vector(1 downto 0);
			SBIT_DLY	: in	std_logic;
			DATA		: in	std_logic_vector(7 downto 0);
			SERVO		: out	std_logic
		);
	end component;


--
-- SIGNALS --
	signal S1MS		: std_logic;
	signal SBIT		: std_logic;
	signal SBIT_DLY	: std_logic;
	signal LDDATA	: std_logic;
	signal START	: std_logic;
	signal MODE		: std_logic_vector(1 downto 0);


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

	I_SERVOUNIT_0 : SERVOUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			START		=> START,
			MODE		=> MODE,
			SBIT_DLY	=> SBIT_DLY,
			DATA		=> DATA,
			SERVO		=> SERVO
		);


end struct;

