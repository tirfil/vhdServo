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


entity SERVOCLOCK is
	port(
		MCLK		: in	std_logic; --50 Mhz
		nRST		: in	std_logic;
		S1MS		: out	std_logic; -- 1 ms
		SBIT		: out	std_logic  -- 1/256 ms
	);
end SERVOCLOCK;

architecture rtl of SERVOCLOCK is
	signal mcounter : std_logic_vector(7 downto 0);
	signal nextcounter : std_logic_vector(7 downto 0);
	signal bitrate : std_logic;
	signal cnt256  : std_logic_vector(8 downto 0);
	signal nextcnt256  : std_logic_vector(8 downto 0);
	signal onems	: std_logic;

begin

	
	bitrate <= mcounter(7) and mcounter(6) and mcounter(2);
	nextcounter <= std_logic_vector(to_unsigned(to_integer(unsigned( mcounter )) + 1, 8));

	MCNT:process(MCLK,nRST)
	begin
		if (nRST = '0') then
			mcounter <= x"01";
		elsif (MCLK'event and MCLK='1') then
			if (bitrate = '1') then
				mcounter <= x"01";
			else
				mcounter <= nextcounter;
			end if;
		end if;
	end process MCNT;

	SBIT <= bitrate;

	onems <= cnt256(8);
	nextcnt256 <= std_logic_vector(to_unsigned(to_integer(unsigned( cnt256 )) + 1, 9));

	DIV256: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			cnt256 <= "0" & x"01";
			S1MS <= '0';
		elsif (MCLK'event and MCLK='1') then
			if (bitrate = '1') then
				if (onems = '1') then
					S1MS <= '1';
					cnt256 <= "0" & x"01";
				else
					cnt256 <= nextcnt256;
				end if;
			else
				S1MS <= '0';
			end if;
		end if;
	end process DIV256;	

	
	

end rtl;

