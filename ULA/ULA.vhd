LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;


ENTITY ULA IS
PORT  ( 	A: in std_logic_vector(3 downto 0);
			B: in std_logic_vector(3 downto 0);
			--S: out std_logic_vector(3 downto 0);
			F: in std_logic_vector(2 downto 0);
			Z: out std_logic;
			VLED: out std_logic;
			display7,display72: out std_logic_vector(6 downto 0)
		);
END ULA;

architecture logica of ULA is

signal VAdder,Vmulti: std_logic;
signal resAdder: std_logic_vector(3 downto 0);

component soma4bits
port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		op: in std_logic;
		saida : out std_logic_vector(3 downto 0);
		over: out std_logic
		
);
end component;

signal sub: std_logic;


signal resMulti: std_logic_vector(3 downto 0);

component multiplicadorx3
port(	a: in std_logic_vector(3 downto 0);
		saida : out std_logic_vector(3 downto 0);
		over: out std_logic
		);
end component;

signal Shifter: std_logic_vector(3 downto 0);

component SR
port (a: in std_logic_vector(3 downto 0);
saida: out std_logic_vector(3 downto 0)
);
end component;

signal saidaint: std_logic_vector(3 downto 0);

signal display: std_logic_vector(6 downto 0);
signal display2 : std_logic_vector(6 downto 0);
signal display1: std_logic_vector(6 downto 0);


begin
	Adder4bits: soma4bits
	port map(a=>A, b=>B, saida=>resAdder,over=>Vadder,op=>sub);
	
	
	
	Multi: multiplicadorx3
	port map(a=>A, saida=>resMulti,over=>Vmulti);
	
	Shift: SR
	port map(a=>B,saida=>Shifter);
	
	sub <='1' WHEN F="011" ELSE
			'0' WHEN F="010";
	
	saidaint(3 downto 0)<=
			(A and B) WHEN F="000" ELSE
			(A or B) WHEN F="001" ELSE
			resAdder WHEN F="010" ELSE   
			resAdder WHEN F="011" ELSE		
			(A xor B) WHEN F="100" ELSE
			Shifter WHEN F="101" ELSE
			not A WHEN F="110" ELSE
			resMulti WHEN F="111";    
			
	
	display<=
	         --"1111110" WHEN (Vadder = '1' and (F="010" or F="011")) ELSE
				--"1111110" WHEN (Vmulti = '1' and  F="111") ELSE
				"0000001" WHEN saidaint="0000" ELSE
				"1001111" WHEN saidaint="0001" ELSE
				"0010010" WHEN saidaint="0010" ELSE
				"0000110" WHEN saidaint="0011" ELSE
				"1001100" WHEN saidaint="0100" ELSE
				"0100100" WHEN saidaint="0101" ELSE
				"0100000" WHEN saidaint="0110" ELSE
				"0001111" WHEN saidaint="0111" ELSE
			   "0000000" WHEN saidaint="1000" ELSE
				"0001111" WHEN saidaint="1001" ELSE
				"0100000" WHEN saidaint="1010" ELSE
				"0100100" WHEN saidaint="1011" ELSE
				"1001100" WHEN saidaint="1100" ELSE
				"0000110" WHEN saidaint="1101" ELSE
				"0010010" WHEN saidaint="1110" ELSE
				"1001111" WHEN saidaint="1111";
				
				
	display7<=display;
	
	display2<=
				 "1111110" WHEN saidaint(3)= '1' ELSE --indica negativos com o LED g do display ligado no HEX1
				 "1111111";
				
	display72<=display2;	
	
	Z<= 
	    '1' WHEN display="0000001" ELSE
		 '0';
		
	VLED<= '1' WHEN (Vadder='1' and ( F="010" or F="011")) ELSE
	       '1' WHEN (Vmulti='1' and ( F="111")) ELSE
			 '0';
		

end logica;