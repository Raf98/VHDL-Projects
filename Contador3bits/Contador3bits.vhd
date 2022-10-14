library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Contador3bits is 
port
(
		clock,hasLoad,clear: in std_logic;
		load: 			in std_logic_vector(2 downto 0);
		Q: 				out std_logic_vector(2 downto 0)
);
end Contador3bits;

architecture conta of Contador3bits is

begin

	process(clock,clear)
		variable count : std_logic_vector(2 downto 0);
		begin
			if(clear = '1')then 
				count := "000";
			else
				if(clock'event and clock = '1')then
					if(hasLoad = '1')then
						count := load;
					else
						count := count + 1;
					end if;
				end if;
			end if;
		q<=count;
	end process;

end conta;
