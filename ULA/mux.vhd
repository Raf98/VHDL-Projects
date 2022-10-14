LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity mux IS
port(
		a: in std_logic;
		b: in std_logic;
		sel: in std_logic;
		saida: out std_logic
		);
end mux;

architecture muxs of mux is 
begin 
saida<=((sel and a) or ((not sel) and b));
end muxs;