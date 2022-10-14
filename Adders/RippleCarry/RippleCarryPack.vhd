LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;


package RippleCarryPack is

	
	component FullAdder IS 
	PORT 
	(
		cin, a, b: 	IN STD_LOGIC;
		s, cout: 	OUT STD_LOGIC
	);
	END component;



component RippleCarry is
generic(num:		integer := 32);
port
(
	c0:	in std_logic;
	a,b:	in std_logic_vector(num-1 downto 0);
	s:		out std_logic_vector(num-1 downto 0);
	cLast:	out std_logic
);
end component;




end RippleCarryPack;