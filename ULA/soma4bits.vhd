LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity soma4bits is
port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		op: in std_logic;
		saida : out std_logic_vector(3 downto 0);
		over: out std_logic
		
);
end soma4bits;

architecture sum of soma4bits is
signal carry : std_logic_vector(3 downto 0);
signal bop: std_logic_vector(3 downto 0);

component somadorCompleto
 port(
		a, b, carryIn : in std_logic;
		saida, carryOut : out std_logic
 );
end component;


begin
	bop(0)<=(b(0) xor op);
	bop(1)<=(b(1) xor op);
	bop(2)<=(b(2) xor op);
	bop(3)<=(b(3)xor op);
	Adder0: somadorCompleto
	port map(a=>a(0), b=>bop(0), saida=>saida(0), CarryIn=>op,CarryOut =>carry(0));
	Adder1: somadorCompleto
	port map(a=>a(1), b=>bop(1), saida=>saida(1), CarryIn=> carry(0), CarryOut =>carry(1));
	
	
	Adder2: somadorCompleto
	port map(a=>a(2), b=>bop(2), saida=>saida(2), CarryIn=>carry(1), CarryOut=>carry(2));
	Adder3: somadorCompleto
	port map(a=>a(3), b=>bop(3), saida=>saida(3), CarryIn=>carry(2), CarryOut=>carry(3));
	
	over<=(carry(3) xor carry(2));
end sum;


