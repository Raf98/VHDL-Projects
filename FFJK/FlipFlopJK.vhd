library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopJK is 
port(
	
	J,K,clock,preset: in std_logic;
	Q,Q_NOT	: out std_logic
	
	);
end FlipFlopJK;

architecture memory of FlipFlopJK is

begin
	
	process(j,k,clock,preset)
	
	variable aux: integer;
	
	begin
		if(preset = '1') then
			aux:=1;
			Q<='1';
			Q_NOT<='0';
			else
			if(clock'event and clock = '1') then 
				if(J = '0' and K = '1')then
					aux:=0;
					Q<='0';
					Q_NOT<='1';
				else
					if(J = '1' and K = '0') then
						aux:=1;
						Q<='1';
						Q_NOT<='0';
					else
						if(J = '1' and K = '1') then
							if(aux = 1) then
								Q<='0';
								Q_NOT<='1';
								aux:=0;
								else
									Q<='1';
									Q_NOT<='0';
									aux:=1;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;

end memory;