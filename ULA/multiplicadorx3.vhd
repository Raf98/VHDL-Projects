LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

entity multiplicadorx3 is 
port(	a: in std_logic_vector(3 downto 0);
		saida : out std_logic_vector(3 downto 0);
		over: out std_logic
		);
end multiplicadorx3;

architecture multi of multiplicadorx3 is


signal intermediario: std_logic_vector(3 downto 0); 
signal overflow: std_logic_vector(1 downto 0);
component soma4bits
port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		op: in std_logic;
		saida : out std_logic_vector(3 downto 0);
		over: out std_logic
		
);
end component;

begin 

	Multix2: soma4bits
	port map(a=>a, b=>a, saida=>intermediario,op=>'0',over=>overflow(0));
	
	Multix3: soma4bits
	port map(a=>intermediario, b=>a, saida=>saida,op=>'0',over=>overflow(1));
	over<=(overflow(1) or overflow(0));

end multi;