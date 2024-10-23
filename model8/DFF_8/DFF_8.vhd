library ieee;
use ieee.std_logic_1164.all;

entity DFF_8 is
port(clk:in std_logic;
		  D:in std_logic_vector(7 downto 0);
		  Q:out std_logic_vector(7 downto 0)
		);
end entity;

architecture bhv of DFF_8 is
SIGNAL Q1 : std_logic_vector(7 downto 0) ; 
begin
	process(clk,Q1)
	begin
		if clk'event and clk='1' then
			Q1<=D;
		end if;
	end process;
	Q<=Q1;
end bhv;