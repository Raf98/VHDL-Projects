library ieee;
use ieee.std_logic_1164.all;

entity Contador4bits is
port
(
	clock: in std_logic;
	Q: out std_logic_vector(3 downto 0)
	
);end;

architecture conta of contador4bits is

component FlipFlopD 
port
(

	D,clock: in std_logic;
	Q	: out std_logic

);end component;

signal conta: std_logic_vector(3 downto 0);

begin

	FF0: FlipFlopD
	port map(D=>(conta(0) XOR '1'), clock=>clock, Q=> conta(0));
	
	FF1: FlipFlopD
	port map(D=>(conta(1) XOR conta(0)), clock=>clock, Q=> conta(1));
	
	FF2: FlipFlopD
	port map(D=>(conta(2) XOR (conta(1) AND conta(0))), clock=>clock, Q=> conta(2));
	
	FF3: FlipFlopD
	port map(D=>(conta(3) XOR (conta(2) AND conta(1) AND conta(0))), clock=>clock, Q=> conta(3));
	
	Q <= conta;


end conta;