library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Seg7 is 
port
(
	entrada: in std_logic_vector(2 downto 0);
	display: out std_logic_vector(6 downto 0)
);
end Seg7;


architecture mostra of Seg7 is

begin

display<=
				"0000001" WHEN entrada="000" ELSE
				"1001111" WHEN entrada="001" ELSE
				"0010010" WHEN entrada="010" ELSE
				"0000110" WHEN entrada="011" ELSE
				"1001100" WHEN entrada="100" ELSE
				"0100100" WHEN entrada="101" ELSE
				"0100000" WHEN entrada="110" ELSE
				"0001111" WHEN entrada="111";				
end mostra;