library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter3bits is 
port
(
		clock,hasLoad,clear: in std_logic;
		load: 			in std_logic_vector(3 downto 0);
		zerou: 			out std_logic;
		Q: 				out std_logic_vector(3 downto 0)
);
end counter3bits;

architecture conta of counter3bits is

begin

	process(clock,clear)
		variable count : std_logic_vector(3 downto 0);
		begin
			if(clear = '1')then 
				count := "0000";
			elsif(hasLoad = '1')then
						count := load;
						zerou <= '0';
				elsif(clock'event and clock = '1')then
--					/*if(hasLoad = '1')then
--						count := load;
--						zerou <= '0';*/
--						--elsif(count = "0000")then
						if(count = "0000")then
							count := "0101";
							zerou <= '1';
							else
								count := count - 1;
								zerou <= '0';
					end if;
				--end if;
			end if;
		Q<=count;
	end process;

end conta;