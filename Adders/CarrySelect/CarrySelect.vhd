library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.CarrySelectPack.all;

entity CarrySelect is
generic(num:		integer := 32);
port
(
	a,b:			in std_logic_vector(num-1 downto 0);
	carryIn:		in std_logic;
	finalOutput:		out std_logic_vector(num-1 downto 0);
	finalCarry:			out std_logic
);
end CarrySelect;


architecture structure of CarrySelect is


signal carryOut:			std_logic_vector(num/2  downto 0);
signal cin:					std_logic_vector(num/4 downto 0);
signal s1,s2:				std_logic_vector(num-1 downto 0);

begin


	cin(0) <= carryIn;

	generateBlocks:
	
	for i in 0 to ((num/4)-1) generate
	
		CS0:			CarrySelectBlock
		
		port map('0', a(((i+1)*4)-1 downto (i*4)  ), b(((i+1)*4)-1 downto (i*4)  ), s1(((i+1)*4)-1 downto (i*4)  ), carryOut(i*2) );
		
		CS1:			CarrySelectBlock
		
		port map('1', a(((i+1)*4)-1 downto (i*4)  ), b(((i+1)*4)-1 downto (i*4)  ), s2(((i+1)*4)-1 downto (i*4)  ), carryOut(i*2+1) );
		
		MuxCout:		Mux
		
		port map(carryOut(i*2), carryOut(i*2+1), cin(i), cin(i+1));
		
		Mux0:			Mux
		
		port map(s1(i*4), s2(i*4), cin(i), finalOutput(i*4));
		
		Mux1:			Mux
		
		port map(s1(((i+1)*4)-3), s2(((i+1)*4)-3), cin(i), finalOutput(((i+1)*4)-3));
		
		Mux2:			Mux
		
		port map(s1(((i+1)*4)-2), s2(((i+1)*4)-2), cin(i), finalOutput(((i+1)*4)-2));
		
		Mux3:			Mux
		
		port map(s1(((i+1)*4)-1), s2(((i+1)*4)-1), cin(i), finalOutput(((i+1)*4)-1));
	
	
	end generate;
	
	finalCarry <= cin(num/4);

end structure;