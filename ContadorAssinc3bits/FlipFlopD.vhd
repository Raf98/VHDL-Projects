library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is 
port(
	
	D,clock,reset: in std_logic;
	Q,Q_NOT	: out std_logic
	
	);
end FlipFlopD;

architecture memory of FlipFlopD is

begin
	
	process(d,clock)
	
	begin
		if(reset = '1') then
			Q<='0';
			Q_NOT<='1';
			else
			if(clock'event and clock = '1') then 
				if(D = '1')then
					Q<='1';
					Q_NOT<='0';
				else
					Q<='0';
					Q_NOT<='1';
				end if;
			end if;
		end if;
	end process;

end memory;