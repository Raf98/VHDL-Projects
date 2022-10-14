library ieee;
use ieee.std_logic_1164.all;

entity RippleCarry is
generic(num:		integer := 32);
port
(
	c0:	in std_logic;
	a,b:	in std_logic_vector(num-1 downto 0);
	s:		out std_logic_vector(num-1 downto 0);
	cLast:	out std_logic
);
end RippleCarry;

architecture structure of RippleCarry is

	signal c:	std_logic_vector(num downto 0);
	
	component FullAdder IS 
	PORT 
	(
		cin, a, b: 	IN STD_LOGIC;
		s, cout: 	OUT STD_LOGIC
	);
	END component;
	
	begin
	
		generateAdders:		
			for i in 0 to num-1 generate
					FA:FullAdder
					port map(c(i), a(i), b(i), s(i), c(i+1));
		end generate generateAdders;
		
		c(0)<= c0;
		cLast<=c(num);
	
	end structure;
	