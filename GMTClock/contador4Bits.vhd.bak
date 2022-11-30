library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter4bits is 
port
(
		clock,hasLoad: in std_logic;
		zerou: out std_logic;
		load: 			in std_logic_vector(3 downto 0);
		Q: 				out std_logic_vector(3 downto 0)
);
end counter4bits;

architecture conta of counter4bits is

begin
--zerou<='0';
--load <= "1001";
	process(clock)
		variable count : std_logic_vector(3 downto 0);
		begin
--			if(load = "0000")then 
--				zerou<='1';
--				count := "1001";
--			else 
--			zerou<='0';
--			end if;
			if(hasLoad = '1')then
					count := load;
					zerou <= '0';
					elsif(clock'event and clock = '1')then
						if(hasLoad = '1')then
							count := load;
							zerou <= '0';
						elsif(count = "0000")then
							count := "1001";
							zerou<='1';
							else
								count := count - 1;
								zerou<='0';
						end if;
			end if;			
		Q<=count;
	end process;

end conta;