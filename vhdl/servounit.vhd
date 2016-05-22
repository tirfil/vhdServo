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
use IEEE.numeric_std.all;

entity SERVOUNIT is
	port(
		MCLK		: in	std_logic;
		nRST		: in	std_logic;
		LDDATA		: in	std_logic;
		START		: in	std_logic;
		MODE		: in	std_logic_vector(1 downto 0);
		SBIT_DLY		: in	std_logic;
		DATA		: in	std_logic_vector(7 downto 0);
		SERVO		: out	std_logic
	);
end SERVOUNIT;

architecture rtl of SERVOUNIT is
	signal cnt	 : std_logic_vector(7 downto 0);
	signal level : std_logic;
	signal mux : std_logic;
	signal selector : std_logic_vector(1 downto 0);

begin

	level <= '0' when (cnt = x"00") else '1';

	CC: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			cnt <= (others=>'0');
		elsif (MCLK'event and MCLK = '1') then
			if (LDDATA = '1') then
				cnt <= DATA;
			elsif ( SBIT_DLY = '1') then
				if (level = '1') then
					cnt <= std_logic_vector(to_unsigned(to_integer(unsigned( cnt )) - 1, 8));
				end if;
			end if;
		end if;
	end process CC;

	CH: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			selector <= "11";
			SERVO <= '0';
		elsif (MCLK'event and MCLK = '1') then
			SERVO <= mux;       -- resync mux output for clean io signal
			if (START = '1') then
				selector <= MODE;
			end if;
		end if;
	end process CH;

	mux <= 		'1' when (selector = "00") else
				level when (selector = "01") else
				'0';


end rtl;

