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

entity SERVOTIMING is
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
end SERVOTIMING;

architecture rtl of SERVOTIMING is
	signal counter : integer range 0 to 19;
	signal sbit_q	: std_logic;

begin

	C1MS: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			counter <= 3;
		elsif (MCLK'event and MCLK = '1') then
			if (S1MS='1') then
				if (counter = 19) then 
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process C1MS;

	LD: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			LDDATA <= '0';
			START <= '0';
		elsif (MCLK'event and MCLK = '1') then
			if (S1MS = '1') then
				START <= '1';
				if (counter = 0 ) then
					LDDATA <='1';
				end if;
			else
				LDDATA <= '0';
				START <= '0';
			end if;
		end if;
	end process LD;

	MDE: process(MCLK,nRST)
	begin
		if (nRST = '0') then
			MODE <= "11";
		elsif (MCLK'event and MCLK = '1') then
			if ( S1MS = '1' ) then
				if (counter = 19) then -- previous value
					MODE <= "00";
				elsif (counter = 0) then -- previous value
					MODE <= "01";
				else
					MODE <= "10";
				end if;
			end if;
		end if;
	end process MDE;

	DELAY: process(MCLK,nRST) -- 2 clock delay to alignment with LDDATA
	begin
		if (nRST = '0') then
			sbit_q <= '0';
			SBIT_DLY <= '0';
		elsif (MCLK'event and MCLK = '1') then
			sbit_q <= SBIT;
			SBIT_DLY <= sbit_q;
		end if;
	end process DELAY;

end rtl;

