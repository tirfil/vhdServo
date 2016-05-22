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

entity SERVO4 is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		DIN		: in	std_logic_vector(7 downto 0);
		DOUT		: out	std_logic_vector(7 downto 0);
		WE		: in	std_logic;
		RD		: in	std_logic;
		ADR		: in	std_logic_vector(1 downto 0);
		CS		: in	std_logic;
		SERVO0		: out	std_logic;
		SERVO1		: out	std_logic;
		SERVO2		: out	std_logic;
		SERVO3		: out	std_logic
	);
end SERVO4;

architecture mixed of SERVO4 is
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
	signal MODE	: std_logic_vector(1 downto 0);
	signal reg0	: std_logic_vector(7 downto 0);
	signal reg1	: std_logic_vector(7 downto 0);
	signal reg2	: std_logic_vector(7 downto 0);
	signal reg3	: std_logic_vector(7 downto 0);


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
			DATA		=> reg0,
			SERVO		=> SERVO0
		);

	I_SERVOUNIT_1 : SERVOUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			START		=> START,
			MODE		=> MODE,
			SBIT_DLY	=> SBIT_DLY,
			DATA		=> reg1,
			SERVO		=> SERVO1
		);

	I_SERVOUNIT_2 : SERVOUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			START		=> START,
			MODE		=> MODE,
			SBIT_DLY	=> SBIT_DLY,
			DATA		=> reg2,
			SERVO		=> SERVO2
		);

	I_SERVOUNIT_3 : SERVOUNIT
		port map (
			MCLK		=> MCLK,
			nRST		=> nRST,
			LDDATA		=> LDDATA,
			START		=> START,
			MODE		=> MODE,
			SBIT_DLY	=> SBIT_DLY,
			DATA		=> reg3,
			SERVO		=> SERVO3
		);

	RWRITE:process(MCLK,nRST)
	begin
		if (nRST='0') then
			reg0 <= (others=>'0');
			reg1 <= (others=>'0');
			reg2 <= (others=>'0');
			reg3 <= (others=>'0');
		elsif (MCLK'event and MCLK='1') then
			if (CS='1' and WE='1') then
				case ADR is
					when "00" 	=> reg0 <= DIN;
					when "01" 	=> reg1 <= DIN;
					when "10" 	=> reg2 <= DIN;
					when others => reg3 <= DIN;
				end case;
			end if;
		end if;
	end process RWRITE;

	DOUT <= reg0 when ADR="00" else
			reg1 when ADR="01" else
			reg2 when ADR="10" else reg3;


end mixed;

