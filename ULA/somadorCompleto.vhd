LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity somadorCompleto is
port(
		a, b, carryIn : in std_logic;
		saida, carryOut : out std_logic
		);
end somadorCompleto;

architecture soma of somadorCompleto is
begin
	saida <= (a xor b) xor carryIn;
	carryOut <= (a and b) or (a and carryIn) or (b and carryIn);
end soma;
