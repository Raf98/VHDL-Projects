library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity Functional is 
generic(num:		integer := 4);
port
(
	a,b:		in std_logic_vector(num-1 downto 0);
	s:			out std_logic_vector(num-1 downto 0)
);
end Functional;

architecture behavior of Functional is 

signal aInt, bInt,sInt:	integer;


begin

	
	aInt <= to_integer(unsigned(a));
	bInt <= to_integer(unsigned(b));

	sInt <= aInt*bInt;
	
	s <= std_logic_vector(to_unsigned(sInt, s'length));

end behavior;