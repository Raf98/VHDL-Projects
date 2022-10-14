LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity latchD is 
port (
		d:in std_logic;
		c:in std_logic;
		q:out std_logic
);end latchD;

architecture memory of latchD is
begin
PROCESS(c,d)
BEGIN
IF c = '1' THEN
IF d = '1' THEN
q <= '1';
ELSE
q<='0';
END IF;
END IF;
END PROCESS;
end memory;
