library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package CarrySelectPack is


component FullAdder IS 
PORT 
(
	cin, a, b: 	IN STD_LOGIC;
	s, cout: 	OUT STD_LOGIC
);
end component;



component CarrySelectBlock is
port
(
	c0:	in std_logic;
	a,b:		in std_logic_vector(3 downto 0);
	s:			out std_logic_vector(3 downto 0);
	cLast:	out std_logic
);
end component;


component Mux is
port
(
	a,b:		in std_logic;
	sel:		in std_logic;
	s:			out std_logic
);
end component;


component CarrySelect is
generic(num:		integer := 32);
port
(
	a,b:			in std_logic_vector(num-1 downto 0);
	carryIn:		in std_logic;
	finalOutput:		out std_logic_vector(num-1 downto 0);
	finalCarry:			out std_logic
);
end component;




end CarrySelectPack;