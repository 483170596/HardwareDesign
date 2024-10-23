library ieee;
use ieee.std_logic_1164.all;

entity IN_SEL is 
port(
    LEFT_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    LD_LEFT: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    RIGHT_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    LD_RIGHT: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    LD_R0, LD_R1, LD_R2: OUT STD_LOGIC;
    D_R0, D_R1, D_R2: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end entity;

architecture bhv of IN_SEL is
begin
	process(LD_LEFT, LD_RIGHT, LEFT_IN, RIGHT_IN)
	begin
        
        -- R0
        IF(LD_LEFT = "00") THEN
            -- LD_R0 <= '1';
            D_R0 <= LEFT_IN;
        ELSE
            -- LD_R0 <= '0';
        END IF;
        IF(LD_RIGHT = "00") THEN
            -- LD_R0 <= '1';
            D_R0 <= RIGHT_IN;
        ELSE
            -- LD_R0 <= '0';
        END IF;

        -- R1
        IF(LD_LEFT = "01") THEN
            -- LD_R1 <= '1';
            D_R1 <= LEFT_IN;
        ELSE
            -- LD_R1 <= '0';
        END IF;
        IF(LD_RIGHT = "01") THEN
            -- LD_R1 <= '1';
            D_R1 <= RIGHT_IN;
        ELSE
            -- LD_R1 <= '0';
        END IF;

        -- R2
        IF(LD_LEFT = "10") THEN
            -- LD_R2 <= '1';
            D_R2 <= LEFT_IN;
        ELSE
            -- LD_R2 <= '0';
        END IF;
        IF(LD_RIGHT = "10") THEN
            -- LD_R2 <= '1';
            D_R2 <= RIGHT_IN;
        ELSE
            -- LD_R2 <= '0';
        END IF;
    
        IF(LD_LEFT = "00" OR LD_RIGHT = "00") THEN
            LD_R0 <= '1';
        ELSE
            LD_R0 <= '0';
        END IF;
        IF(LD_LEFT = "01" OR LD_RIGHT = "01") THEN
            LD_R1 <= '1';
        ELSE
            LD_R1 <= '0';
        END IF;
        IF(LD_LEFT = "10" OR LD_RIGHT = "10") THEN
            LD_R2 <= '1';
        ELSE
            LD_R2 <= '0';
        END IF;

	end process;
end bhv;