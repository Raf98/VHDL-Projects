library ieee;
use ieee.std_logic_1164.all;

entity regis4 is
port(
D: in std_logic_vector(3 downto 0);
clock,clear, load: in std_logic;
Q: out std_logic_vector(3 downto 0)
);
end regis4;

architecture daniela of regis4 is

component Registrador1bit is
port(

		D,clock,clear,load: in std_logic;
		Q						: out std_logic
		
	);
end component;
begin
regis00: Registrador1bit port map(D=>D(0),clock=>clock,clear=>clear,load=>load, Q=>Q(0));

regis01:Registrador1bit port map(D=>D(1),clock=>clock,clear=>clear,load=>load, Q=>Q(1));

regis02:Registrador1bit port map(D=>D(2),clock=>clock,clear=>clear,load=>load, Q=>Q(2));

regis03: Registrador1bit port map(D=>D(3),clock=>clock,clear=>clear,load=>load, Q=>Q(3));

end daniela;
