library ieee;
use ieee.std_logic_1164.all;

entity Registrador1bit is 
port(

		D,clock,clear,load: in std_logic;
		Q						: out std_logic
		
	);
end Registrador1bit;


architecture registra of Registrador1bit is


begin


	process(clock,clear)
	
	variable aux: std_logic;
	
		begin
			
			if(clear = '1') then
				Q<='0';
				aux := '0';
			else
				if(clock'event and clock = '1') then
					if(load = '1') then
						Q<=D;
						aux:=D;
					else
						if(load = '0') then
							Q<=aux;
						end if;
					end if;
				end if;
			end if;
	end process;


end registra;