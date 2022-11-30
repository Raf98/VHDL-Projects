Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

 entity Divider is
	 port (
		 CLK: in STD_LOGIC;
		 COUT: out STD_LOGIC;
		 COUT2: out STD_LOGIC;
		 COUT4: out STD_LOGIC
		 );
 end Divider; 

 architecture arc_Divider of Divider is 

	constant TIMECONST1 : integer := 80;--100
	constant TIMECONST2 : integer := 40;--50
	constant TIMECONST3 : integer := 20;--25
	constant TIMECONST4 : integer := 10;--13
 
	signal count0, count1, count2, count3: integer range 0 to 1000 := 0;
	signal count4, count5, count6, count7: integer range 0 to 1000 := 0;
	signal count8, count9, count10, count11: integer range 0 to 1000 := 0;

	signal regr: STD_LOGIC := '0';
	signal regr2: STD_LOGIC := '0';
	signal regr4: STD_LOGIC := '0';

 begin 
	 process (CLK)
	 begin
		if(clk'event and clk='1')then
			count0 <= count0 + 1;						--1Hz
			if(count0 = TIMECONST1)then
				count0<=0;
				count1 <= count1 + 1;
				elsif(count1 = TIMECONST1)then
					count1<=0;
					count2 <= count2 + 1;
					elSif(count2 = TIMECONST1)then 
						count2<=0;
						count3 <= count3 + 1;
						elsif(count3 = TIMECONST2)then
							count3<=0;
							regr<= not regr;
		end if;
		
		count4 <= count4 + 1;						--2Hz
		if(count4 = TIMECONST1)then
			count4<=0;
			count5 <= count5 + 1;
			elsif(count5 = TIMECONST1)then
				count5<=0;
				count6 <= count6 + 1;
				elSif(count6 = TIMECONST1)then 
					count6<=0;
					count7 <= count7 + 1;
					elsif(count7 = TIMECONST3)then
							count7<=0;
							regr2<= not regr2;
		end if;
		
		count8 <= count8 + 1;						--4Hz
		if(count8 = TIMECONST1)then
			count8<=0;
			count9 <= count9 + 1;
			elsif(count9 = TIMECONST1)then
				count9<=0;
				count10 <= count10 + 1;
				elSif(count10 = TIMECONST1)then 
					count10<=0;
					count11 <= count11 + 1;
					elsif(count11 = TIMECONST4)then
							count11<=0;
							regr4<= not regr4;
		end if;
	end if;
 end process;
 
 COUT <= regr;
 COUT2 <= regr2;
 COUT4 <= regr4;

 end arc_Divider;