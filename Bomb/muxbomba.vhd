library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity muxbomba is
port(
sel: in std_logic_vector(1 downto 0);
--a: in std_logic_vector(3 downto 0);
desliga,regr,regr2,regr4: std_logic;
c: out std_logic
);
end muxbomba;

architecture mux of muxbomba is
begin

c<=
		desliga WHEN sel="00" ELSE
		regr WHEN sel="01" ELSE
		regr2 WHEN sel="10" ELSE
		regr4 WHEN sel="11";
	end mux;