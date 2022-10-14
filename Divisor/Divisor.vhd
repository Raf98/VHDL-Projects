library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Divisor is 
port
(
	clock: in std_logic;
	display: out std_logic_vector(6 downto 0)
);
end Divisor;

architecture contador of Divisor is
	
	component Divider is
		port (
			CLK: in STD_LOGIC;
			COUT: out STD_LOGIC
			);
	end component; 
 
	component Contador3bits is
	port
	(
			clock,hasLoad,clear: in std_logic;
			Q: 				out std_logic_vector(2 downto 0)
	);
	end component;

	component Seg7 is
	port
	(
		entrada: in std_logic_vector(2 downto 0);
		display: out std_logic_vector(6 downto 0)
	);
	end component;
	
	signal saidaDivisor: std_logic;
	signal saidaContador: std_logic_vector(2 downto 0);
	--signal saidaSeg7: std_logic_vector(6 downto 0);
	
	begin
	 
	DivisorFreq: Divider
	port map(CLK=>clock,COUT=>saidaDivisor);

	Count: Contador3bits
	port map(clock=>saidaDivisor,hasLoad=>'0', clear=>'0', Q=>saidaContador);
	
	Countii: Seg7
	port map(entrada=>saidaContador, display=>display);
	



end contador;