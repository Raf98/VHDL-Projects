library ieee;
use ieee.std_logic_1164.all;

entity ContadorAssinc3bits is
port
(
	clock : 		in std_logic;
	--D: 			in std_logic_vector(2 downto 0);
	Q:				out std_logic_vector(2 downto 0);
	Q_NOT: 		out std_logic_vector(2 downto 0)
	
);end; 

architecture conta of contadorAssinc3bits is

component FlipFlopD
port
(

	D,clock: in std_logic;
	Q,Q_NOT	: out std_logic
);end component;

signal K :std_logic_vector(2 downto 0);
begin
flip1:FlipFlopD 
	port map(D=>K(0),clock=>clock,Q=>Q(0),Q_NOT=>K(0));
	
flip2:FlipFlopD 
	port map(D=>K(1),clock=>K(0),Q=>Q(1),Q_NOT=>K(1));
	
flip3:FlipFlopD 
	port map(D=>K(2),clock=>k(1),Q=>Q(2),Q_NOT=>K(2));
	
Q_NOT<=K;


end conta;