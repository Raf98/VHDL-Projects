library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador4Bits is 
port
(
		clock,hasLoad: in std_logic;
		outReachedNine: out std_logic;
		load: 			in std_logic_vector(3 downto 0);
		Q: 				out std_logic_vector(3 downto 0)
);
end contador4Bits;

architecture conta of contador4Bits is

begin

	process(clock)
		variable count : std_logic_vector(3 downto 0);
		begin
			if(hasLoad = '1')then
					count := load;
					outReachedNine <= '0';
			elsif(clock'event and clock = '1')then
				if(hasLoad = '1')then
					count := load;
					outReachedNine <= '0';
				elsif(count = "1001")then
					count := "0000";
					outReachedNine<='1';
				else
					count := count + 1;
					outReachedNine<='0';
				end if;
			end if;			
		Q<=count;
	end process;

end conta;