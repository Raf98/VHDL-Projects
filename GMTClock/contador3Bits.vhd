library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador3Bits is 
port
(
		clock,hasLoad,clear: in std_logic;
		load: 			in std_logic_vector(3 downto 0);
		reachedFive: 			out std_logic;
		Q: 				out std_logic_vector(3 downto 0)
);
end contador3Bits;

architecture conta of contador3Bits is

begin

	process(clock,clear)
		variable count : std_logic_vector(3 downto 0);
		begin
			if(clear = '1')then 
				count := "0000";
			elsif(hasLoad = '1')then
						count := load;
						reachedFive<= '0';
				elsif(clock'event and clock = '1')then
						if(count = "0101")then
							count := "0000";
							reachedFive <= '1';
							else
								count := count + 1;
								reachedFive <= '0';
					end if;
			end if;
		Q<=count;
	end process;

end conta;