library ieee;
use ieee.std_logic_1164.all;

library work;
use work.CarrySelectPack.all;

entity CarrySelectBlock is
port
(
	c0:	in std_logic;
	a,b:		in std_logic_vector(3 downto 0);
	s:			out std_logic_vector(3 downto 0);
	cLast:	out std_logic
);
end CarrySelectBlock;


architecture structure of CarrySelectBlock is



	signal c:	std_logic_vector(4 downto 0);
	
	begin
	
		generateAdders:		
			for i in 0 to 3 generate
					FA:FullAdder
					port map(c(i), a(i), b(i), s(i), c(i+1));
		end generate generateAdders;
		
		c(0)<= c0;
		cLast<=c(4);

end structure;