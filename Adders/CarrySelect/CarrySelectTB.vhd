LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
use STD.textio.all;


library work;
use work.CarrySelectPack.all;

entity CarrySelectTB is
  generic(num:		integer := 32);
end CarrySelectTB;

architecture behavior of CarrySelectTB is


--------------------FunÃƒÂ§oes de conversao de string/stdlogic----------------


function strToStdVector(inp: string) return std_logic_vector is
variable temp: std_logic_vector(inp'range);
begin
    for i in inp'range loop
	     if (inp(i) = '1') then
		      temp(i):= '1';
		  elsif(inp(i)='0') then
		      temp(i):= '0';
		  end if;
	 end loop;
	 return temp; 
end function strToStdVector;

function stdVectorToStr(inp: std_logic_vector) return string is
variable temp: string(inp'left+1 downto 1);
begin
    for i in inp'reverse_range loop
	     if (inp(i) = '1') then
		      temp(i+1):= '1';
		  elsif(inp(i)='0') then
		      temp(i+1):= '0';
		  end if;
	 end loop;
	 return temp; 
end function stdVectorToStr;



function stdToStr(inp: std_logic) return string is
variable temp: string(1 downto 1);
begin
	if (inp = '1') then
		temp(1):= '1';
	elsif(inp ='0') then
		temp(1):= '0';
	end if;
	 
	return temp; 
end function stdToStr;





--Sinais

signal clock:			std_logic;
signal a,b:				std_logic_vector(num-1 downto 0);
signal s:				std_logic_vector(num-1 downto 0);
signal cLast:			std_logic;

begin

DUT:	CarrySelect

port map(a, b ,'0' ,s, cLast);





	ClockProcess:process
	begin

		clock <= '1', '0' after 12 ps;
		wait for 24 ps;

	end process;
	
	
	
	
	
	
	
	
	ReadFile:process(clock)
	
	file fileType: 		text;
	
	variable inA:			std_logic_vector(num-1 downto 0);
	variable inB:			std_logic_vector(num-1 downto 0);
	
	variable strA: 		string(num downto 1);
	variable strB:			string(num downto 1);
	
	variable lineType: 	line;
	
	begin
	
		FILE_OPEN(fileType,"entrada.txt",READ_MODE);
		
		if clock'event and clock = '1' then
		
			--FILE_OPEN(fileType,"C:/Users/Aluno/Documents/SDA/DatapathTB/entrada.txt",READ_MODE);
		   readline(fileType,lineType);
		   read(lineType,strA);
		   inA := strToStdVector(strA);
		
		   a <= inA;
			
			
			readline(fileType,lineType);
		   read(lineType,strB);
		   inB := strToStdVector(strB);
		
		   b <= inB;
	
		end if;	

		
	end process;
	
	
	WriteFile: process(clock)
	
	file outFile : text;
	variable outS: 	std_logic_vector(num-1 downto 0);
	variable strS : 	string(num downto 1);
	variable outFinal:std_logic; 
	variable lineArg : line;
	variable tempLine : string(10 downto 1);
	variable strOut:		string(1 to 1);
		
	begin
	 
		FILE_OPEN(outFile,"saida.txt",WRITE_MODE);
	
	
	if clock'event and clock = '0' then
	
		tempLine := "Carry Out:";
		write(lineArg,tempLine);
		writeline(outFile,lineArg);
		outFinal := cLast;
		strOut := stdToStr(outFinal);
	   write(lineArg,strOut);
	   writeline(outFile,lineArg);
		
		tempLine := "Output:   ";
		write(lineArg,tempLine);
		writeline(outFile,lineArg);
		outS := s;
		strS := stdVectorToStr(outS);
	   write(lineArg,strS);
	   writeline(outFile,lineArg);
		
	end if;
	
	end process;
	
	
	
	
end behavior;
	

