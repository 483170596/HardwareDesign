library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SM is
	port(
		CLK	 : in	std_logic; -- 时钟信号
        I    : in	std_logic_vector(7 downto 0); -- 指令
		RST	 : in	std_logic; -- 复位信号
		CTL	 : out	std_logic_vector(18 downto 0)); -- 控制信号
end entity;

architecture rtl of SM is
	-- 这里写下所有的状态
	type state_type is (s0, s1, s2, s3, s4, s5, s6);
	signal state   : state_type;

begin
    -- 这个进程控制状态机的状态转移有关，需要用到信号CLK、RST、I
	process (CLK, RST, I)
	begin
        -- 如果复位信号为1，则状态机回到初始状态
		if RST = '1' then
			state <= s0;
        -- 如果时钟信号为上升沿，则状态机状态转移
		elsif (rising_edge(CLK)) then
			case state is
				when s0=>
                    -- 初始状态下，状态机转移到s1
					state <= s1;
				when s1=>
                    -- 如果指令的高四位为0000，则状态机转移到s2
                    -- 如果指令的高四位为0101或0010，则状态机转移到s3
                    -- 如果指令的高四位为1000，则状态机转移到s6
                    -- 后面的状态转移同理
					if (I(7 downto 4) = "0000") then
						state <= s2;
					elsif (I(7 downto 4) = "0101" or I(7 downto 4) = "0010") then
						state <= s3;
                    elsif (I(7 downto 4) = "1000") then
                        state <= s6;
					end if;
				when s2=>
                    state <= s0;
				when s3 =>
					if I(7 downto 4) = "0101" then
                        state <= s4;
                    elsif I(7 downto 4) = "0010" then
                        state <= s5;
					end if;
                when s4 =>
					state <= s0;
                when s5 =>
                    state <= s0;
                when s6 =>
                    state <= s0;
			end case;
		end if;
	end process;

	-- 这个进程控制状态机的输出CTL，需要用到信号state和I
    -- 根据状态机的状态，输出对应的控制信号，控制信号来源于信号控制表的每一行
	process (state, I)
	begin
		case state is
			when s0 =>
                -- s0状态下，输出对应的控制信号,就是表的第一行，以此类推
				CTL <= "0111111110001000110";
			when s1 =>
				CTL <= "0111111110000010001";
			when s2 =>
                -- 表的第三行，注意这里的RD用I(3 downto 2)即指I的第4、3位代替，以此类推
				CTL <= "111"& I(3 downto 2) &"11110000000000";
			when s3 =>
				CTL <= "01111"& I(3 downto 0) &"1000000000";
            when s4 =>
                CTL <= "0"& I(3 downto 2) &"1111110010000000";
            when s5 =>
                CTL <= "0"& I(3 downto 2) &"1111110100000000";
            when s6 =>
                CTL <= "0111111"& I(3 downto 2) &"0000001100";
		end case;
	end process;
end rtl;