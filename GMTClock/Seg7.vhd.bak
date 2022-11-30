library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Seg7 is 
port
(
	entrada: in std_logic_vector(3 downto 0);
	display: out std_logic_vector(6 downto 0)
);
end Seg7;


architecture mostra of Seg7 is

begin

display<=
				"0000001" WHEN entrada="0000" ELSE		--0
				"1001111" WHEN entrada="0001" ELSE		--1 ou i
				"0010010" WHEN entrada="0010" ELSE		--2
				"0000110" WHEN entrada="0011" ELSE		--3
				"1001100" WHEN entrada="0100" ELSE		--4
				"0100100" WHEN entrada="0101" ELSE		--5 ou S
				"0100000" WHEN entrada="0110" ELSE		--6
				"0001111" WHEN entrada="0111" ELSE		--7
				"0000000" WHEN entrada="1000" ELSE		--8
				"0000100" WHEN entrada="1001" ELSE		--9
				"0010000" WHEN entrada="1010" ELSE		--e
				"1101010" WHEN entrada="1011" ELSE		--n
				"0111000" WHEN entrada="1100" ELSE		--F
				"1100011" WHEN entrada="1101" ELSE		--u
				"1000010" WHEN entrada="1110" ELSE		--d		
				"1111111" WHEN entrada="1111";			--apaga todos	
end mostra;