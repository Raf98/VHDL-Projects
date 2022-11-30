library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-------------------------------------------------Entradas e Saidas----------------------------------------------

entity Relogio is 
port(	selGMT: 				in std_logic_vector(3 downto 0);							--seletor dos fuso horarios
		clock: 				in std_logic;													--clock da placa			
		showDisplaySeg1: 	out std_logic_vector(6 downto 0);						--saida para mostrar a unidade de segundo no display
		showDisplaySeg2: 	out std_logic_vector(6 downto 0);						--saida para mostrar a dezena de segundo no display
		showDisplayMin1: 	out std_logic_vector(6 downto 0);						--saida para mostrar a unidade de minuto no display
		showDisplayMin2: 	out std_logic_vector(6 downto 0);						--saida para mostrar a dezena de minuto no display
		showDisplayHour1:	out std_logic_vector(6 downto 0);						--saida para mostrar a unidade de hora no display
		showDisplayHour2: out std_logic_vector(6 downto 0);						--saida para mostrar a dezena de hora no display
		selOp:				in std_logic;													--seleciona a operacao do relogio	
		setRelogio:			in std_logic_vector(2 downto 0);							--seleciona qual unidade de tempo inserir
		buttonIn:			in std_logic;													--pushbutton de entradas de unidades de tempo
		setNewGMT:        in std_logic;													--selecao de GMT atual
		setSummerTime:		in std_logic													--mostra o horario de verao
		);
end Relogio;


architecture control of Relogio is

------------------------------------------Componentes-----------------------------------------------------------

component Seg7 is 
port
(
	entrada: 					in std_logic_vector(3 downto 0);
	display: 					out std_logic_vector(6 downto 0)
);
end component;

component contador3Bits is 
port
(
		clock,hasLoad: in std_logic;
		load: 					in std_logic_vector(3 downto 0);
		reachedFive: 			out std_logic;
		Q: 						out std_logic_vector(3 downto 0)
);
end component;

component contador4Bits is 
port
(
		clock,hasLoad: 		in std_logic;
		outReachedNine: 		out std_logic;
		load: 					in std_logic_vector(3 downto 0);
		Q: 						out std_logic_vector(3 downto 0)
);
end component;

 component Divider is
	 port (
		 CLK: in STD_LOGIC;
		 COUT: out STD_LOGIC
		 );
 end component; 
 
 
 ----------------------------------------------------------Sinais---------------------------------------------------------------------
 
	signal hasLoad1,hasLoad2,hasLoad3,hasLoad4,hasLoad5,hasLoad6 :std_logic;						--flag que habilita o load dos valores passados aos contadores
	signal load1,load2,load3,load4,load5,load6,signalbutton: std_logic_vector(3 downto 0);		--sinais de load do relogio
	signal reachedLimit: 	std_logic_vector(5 downto 0);									
	signal clockSegs: 		std_logic;															--clock de 1Hz
	signal mapDisplaySeg1: 	std_logic_vector(3 downto 0);									--sinais de interface dos contadores com os displays
	signal mapDisplaySeg2: 	std_logic_vector(3 downto 0);
	signal mapDisplayMin1: 	std_logic_vector(3 downto 0);
	signal mapDisplayMin2: 	std_logic_vector(3 downto 0);
	signal mapDisplayHour1: std_logic_vector(3 downto 0);
	signal mapDisplayHour2: std_logic_vector(3 downto 0);
	signal valueHour1,valueHour2: std_logic_vector(3 downto 0);


--------------------------------------------------------Processos-----------------------------------------------------------------	
	
begin



	process(clock,selOp,setRelogio,selGMT)											--processo de ajustar/acionar o relogio
	variable keepValue1, keepValue2: std_logic_vector(3 downto 0);
	--variable parseHour1,parseHour2: std_logic_vector(3 downto 0);
	begin
	
	
		if(clock= '1' and clock'event)then
			if(selOp = '0')then
				hasload1<='1';
				hasload2<='1';
				hasload3<='1';
				hasload4<='1';
				hasload5<='1';
				hasload6<='1';
				if(setRelogio = "000")then										--unidade de segundo selecionada
					load1<=signalbutton;
				elsif(setRelogio="001")then									--dezena de segundo selecionada
					load2<=signalbutton;
				elsif(setRelogio="011")then									--unidade de minuto selecionada
					load3<=signalbutton;
				elsif(setRelogio="111")then									--dezena de minuto selecionada
					load4<=signalbutton;
				elsif(setRelogio="110")then									--unidade de hora selecionada
					load5<=signalbutton;
					--valueHour1<=signalbutton;
				elsif(setRelogio="100")then									--dezena de hora selecionada
					load6<=signalbutton;
					--valueHour2<=signalbutton;
				end if;
			elsif(selOp='1')then													--se for 1, inicia  a contagem
				hasload1<='0';
				hasload2<='0';
				hasload3<='0';
				hasload4<='0';
				hasload5<='0';
				hasload6<='0';
				if(mapDisplayHour1="0100" and mapDisplayHour2 = "0010")then --se chegar a 24 horas, reinicia o relogio
					load1<="0000";
					load2<="0000";
					load3<="0000";
					load4<="0000";
					load5<="0000";
					load6<="0000";
					hasLoad1<='1';
					hasload2<='1';
					hasload3<='1';
					hasload4<='1';
					hasload5<='1';
					hasload6<='1';
				end if;
				
				
				if(setNewGMT = '1')then 
					if(selGMT = "0000")then												--0
						keepValue1 := valueHour1 + setSummerTime;
						keepValue2 := valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0110" and setSummerTime = '1')then				-- -1 com horario de verao
						
						keepValue1 := valueHour1;
						keepValue2 := valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0001")then											-- +1
						keepValue1 := valueHour1 + "0001" + setSummerTime;
						keepValue2 := valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0010")then										-- +2
						keepValue1:=valueHour1+"0010" + setSummerTime;
						keepValue2:=valueHour2;

						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0011")then										-- +3
						keepValue1:=valueHour1+"0011" + setSummerTime;
						keepValue2:=valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0100")then										-- +4
						keepValue1:=valueHour1+"0100" + setSummerTime;
						keepValue2:=valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							keepValue1 := keepValue1 - "1010";
							keepValue2 :=keepValue2+"0001";
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
						
					elsif(selGMT = "0101")then									-- +5
						keepValue1:=valueHour1+"0101" + setSummerTime;
						keepValue2:=valueHour2;
						
						if(keepValue1 >= "1010" and (keepValue2 = "0000" or keepValue2 = "0001"))then
							if(keepValue1 = "1110" and keepValue2 = "0001")then
								keepValue1 := "0000";
								keepValue2 := "0000";
							else
								keepValue1 := keepValue1 - "1010";
								keepValue2 :=keepValue2+"0001";
							end if;
						elsif(keepValue1 >= "0100" and keepValue2 = "0010")then
							keepValue1 :=keepValue1 - "0100";
							keepValue2 :="0000";
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "0110" or (selGMT = "0111" and setSummerTime = '1'))then										-- -1
						--keepValue1:=valueHour1;
						--keepValue2:=valueHour2;
						if(valueHour1 = "0000" and valueHour2 = "0000")then					--00
							keepValue1:="0011";
							keepValue2:="0010";
							elsif(valueHour1 = "0000" and valueHour2 = "0010")then			--10
								keepValue1:="1001";
								keepValue2:="0001";
								elsif(valueHour1 = "0000" and valueHour2 = "0001")then		--20
									keepValue1:="1001";
									keepValue2:="0000";
								else
									keepValue1:=valueHour1 - "0001";
									keepValue2:=valueHour2;
									
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
					elsif(selGMT = "0111" or (selGMT = "1000" and setSummerTime = '1'))then										-- -2
						--keepValue1:=valueHour1-2;
						--keepValue2:=valueHour2;
						
						if(valueHour1 = "0000" and valueHour2 = "0000")then					--00
							keepValue1:="0010";
							keepValue2:="0010";
							elsif(valueHour1 = "0000" and valueHour2 = "0010")then			--20
								keepValue1:="1000";
								keepValue2:="0001";
								elsif(valueHour1 = "0000" and valueHour2 = "0001")then		--10
									keepValue1:="1000";
									keepValue2:="0000";
									elsif(valueHour1 = "0001" and valueHour2 = "0000")then	--01
										keepValue1:="0011";
										keepValue2:="0010";
										elsif(valueHour1 = "0001" and valueHour2 = "0010")then	--21
											keepValue1:="1001";
											keepValue2:="0001";
											elsif(valueHour1 = "0001" and valueHour2 = "0001")then --11
												keepValue1:="1001";
												keepValue2:="0000";
												else
													keepValue1:=valueHour1 - "0010";
													keepValue2:=valueHour2;
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
						
						
					elsif(selGMT = "1000" or (selGMT = "1001" and setSummerTime = '1'))then										-- -3
						--keepValue1:=valueHour1-3;
						--keepValue2:=valueHour2;
						
						if(valueHour1 = "0000" and valueHour2 = "0000")then							--00
							keepValue1:="0001";
							keepValue2:="0010";
							elsif(valueHour1 = "0000" and valueHour2 = "0010")then					--20
								keepValue1:="0111";
								keepValue2:="0001";
								elsif(valueHour1 = "0000" and valueHour2 = "0001")then				--10
									keepValue1:="0111";
									keepValue2:="0000";
									elsif(valueHour1 = "0001" and valueHour2 = "0000")then			--01
										keepValue1:="0010";
										keepValue2:="0010";
										elsif(valueHour1 = "0001" and valueHour2 = "0010")then		--21
											keepValue1:="1000";
											keepValue2:="0001";
											elsif(valueHour1 = "0001" and valueHour2 = "0001")then	--11
												keepValue1:="1000";
												keepValue2:="0000";
												elsif(valueHour1 = "0010" and valueHour2 = "0000")then		--02
													keepValue1:="0011";
													keepValue2:="0010";
													elsif(valueHour1 = "0010" and valueHour2 = "0010")then		--22
														keepValue1:="1001";
														keepValue2:="0001";
														elsif(valueHour1 = "0010" and valueHour2 = "0001")then		--12
															keepValue1:="1001";
															keepValue2:="0000";
												else
													keepValue1:=valueHour1 - "0011";
													keepValue2:=valueHour2;
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "1001" or (selGMT = "1010" and setSummerTime = '1'))then										-- -4
						--keepValue1:=valueHour1-4;
						--keepValue2:=valueHour2;
						
						if(valueHour1 = "0000" and valueHour2 = "0000")then							--00
							keepValue1:="0000";
							keepValue2:="0010";
							elsif(valueHour1 = "0000" and valueHour2 = "0010")then					--20
								keepValue1:="0110";
								keepValue2:="0001";
								elsif(valueHour1 = "0000" and valueHour2 = "0001")then				--10
									keepValue1:="0110";
									keepValue2:="0000";
									elsif(valueHour1 = "0001" and valueHour2 = "0000")then			--01
										keepValue1:="0001";
										keepValue2:="0010";
										elsif(valueHour1 = "0001" and valueHour2 = "0010")then		--21
											keepValue1:="0111";
											keepValue2:="0001";
											elsif(valueHour1 = "0001" and valueHour2 = "0001")then	--11
												keepValue1:="0111";
												keepValue2:="0000";
												elsif(valueHour1 = "0010" and valueHour2 = "0000")then		--02
													keepValue1:="0010";
													keepValue2:="0010";
													elsif(valueHour1 = "0010" and valueHour2 = "0010")then		--22
														keepValue1:="1000";
														keepValue2:="0001";
														elsif(valueHour1 = "0010" and valueHour2 = "0001")then		--12
															keepValue1:="1000";
															keepValue2:="0000";
															elsif(valueHour1 = "0011" and valueHour2 = "0000")then		--03
																keepValue1:="0011";
																keepValue2:="0010";
																elsif(valueHour1 = "0011" and valueHour2 = "0010")then		--23
																	keepValue1:="1001";
																	keepValue2:="0001";
																	elsif(valueHour1 = "0011" and valueHour2 = "0001")then		--13
																		keepValue1:="1001";
																		keepValue2:="0000";
												else
													keepValue1:=valueHour1 - "0100";
													keepValue2:=valueHour2;
						
						end if;
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					elsif(selGMT = "1010")then										-- -5
						--keepValue1:=valueHour1-5;
						--keepValue2:=valueHour2;
								
						if(valueHour1 = "0000" and valueHour2 = "0000")then							--00
							keepValue1:="1001";
							keepValue2:="0001";
							elsif(valueHour1 = "0000" and valueHour2 = "0010")then					--20
								keepValue1:="0101";
								keepValue2:="0001";
								elsif(valueHour1 = "0000" and valueHour2 = "0001")then				--10
									keepValue1:="0101";
									keepValue2:="0000";
									elsif(valueHour1 = "0001" and valueHour2 = "0000")then			--01
										keepValue1:="0000";
										keepValue2:="0010";
										elsif(valueHour1 = "0001" and valueHour2 = "0010")then		--21
											keepValue1:="0110";
											keepValue2:="0001";
											elsif(valueHour1 = "0001" and valueHour2 = "0001")then	--11
												keepValue1:="0110";
												keepValue2:="0000";
												elsif(valueHour1 = "0010" and valueHour2 = "0000")then		--02
													keepValue1:="0001";
													keepValue2:="0010";
													elsif(valueHour1 = "0010" and valueHour2 = "0010")then		--22
														keepValue1:="0111";
														keepValue2:="0001";
														elsif(valueHour1 = "0010" and valueHour2 = "0001")then		--12
															keepValue1:="0111";
															keepValue2:="0000";
															elsif(valueHour1 = "0011" and valueHour2 = "0000")then		--03
																keepValue1:="0010";
																keepValue2:="0010";
																elsif(valueHour1 = "0011" and valueHour2 = "0010")then		--23
																	keepValue1:="1000";
																	keepValue2:="0001";
																	elsif(valueHour1 = "0011" and valueHour2 = "0001")then		--13
																		keepValue1:="1000";
																		keepValue2:="0000";
																		elsif(valueHour1 = "0100" and valueHour2 = "0000")then		--04
																			keepValue1:="0011";
																			keepValue2:="0010";
																				elsif(valueHour1 = "0100" and valueHour2 = "0001")then		--14
																					keepValue1:="1001";
																					keepValue2:="0000";
																					else
																						keepValue1:=valueHour1 - "0101";
																						keepValue2:=valueHour2;
						end if;
						
						load5<=keepValue1;
						load6<=keepValue2;
						hasLoad5<='1';
						hasLoad6<='1';
						
					end if;
					
				end if;
				
				
			end if;
		end if;
	end process;
	
	
	
	process(reachedLimit,selOp)																		--processo de troca do GMT 0 quando ha mudanca no horario 1 
	variable parseHour1,parseHour2: std_logic_vector(3 downto 0);
	begin
	if(selOp = '0')then
		valueHour1<=load5;
		valueHour2<=load6;
	elsif(selOp = '1')then
	if(reachedLimit(3) = '1' and reachedLimit(3)'event)then
					parseHour1:=valueHour1 + "0001";
					parseHour2 := valueHour2;
					if(parseHour1 = "1010" and (parseHour2 = "0000" or parseHour2 = "0001"))then
						parseHour1:="0000";
						parseHour2:=parseHour2 + "0001";
						elsif(parseHour1 = "0100" and parseHour2 = "0010")then
							parseHour1:="0000";
							parseHour2:="0000";
					end if;
						valueHour1<=parseHour1;
						valueHour2<=parseHour2;
	end if;
	end if;
	end process;			
	
	
	
	
	process(buttonIn)																--processo de tratamento de entradas do botao
	variable botsoma: std_logic_vector(3 downto 0);
	begin
		if(selOp = '0')then
			if(buttonIn = '0' and buttonIn'event)then						--se o botao for pressionado, adiciona mais um no botsoma
				botsoma:=botsoma+1;
			end if;
				if(botsoma="1010" and (setRelogio="000" or setRelogio="011" or setRelogio="110")) then	--se botsoma chegar a 10 e for unidade de segundo ou de minuto, zera o load1 ou o load3
					botsoma:="0000";
					elsif(botsoma>="0110" and (setRelogio="001" or setRelogio="111"))then	--se botsoma chegar a 6 e for dezena de segundo ou de minuto, zera o load2 ou o load4
						botsoma:="0000";
						--elsif(botsoma>="1010" and (setRelogio="110"))then					--se botsoma chegar a 10 e for unidade de hora, zera o load5
							--botsoma:="0000";
							elsif(botsoma>="0011" and (setRelogio="100"))then				--se botsoma chegar a 3 e for dezena de hora, zera o load6
								botsoma:="0000";
				end if;
			if(load5>="0100" and load6 = "0010" and(setRelogio = "110" or setRelogio = "100"))then --se load5 for 4 ou mais e load6 for dois e for unidade ou dezena de hora, zera o botsoma
				botsoma:="0000";
			end if;
		end if;
		
	signalbutton<=botsoma;
	end process;
	
	----------------------------------------------------------Port Maps----------------------------------------------------------------
	
	DivisorFreq: Divider
	port map(CLK=>clock, COUT=>clockSegs);
	
	contadorSeg1: contador4Bits
	port map(clock=>clockSegs and selOp, outReachedNine=>reachedLimit(0), hasLoad=>hasLoad1, load=>load1, Q=> mapDisplaySeg1);
	
	contadorSeg2: contador3Bits
	port map(clock=>reachedLimit(0), reachedFive=>reachedLimit(1), hasLoad=>hasLoad2, load=>load2, Q=> mapDisplaySeg2);
	
	contadorMin1: contador4Bits
	port map(clock=>reachedLimit(1), outReachedNine=>reachedLimit(2), hasLoad=>hasLoad3, load=>load3, Q=> mapDisplayMin1);
	
	contadorMin2: contador3Bits
	port map(clock=>reachedLimit(2), reachedFive=>reachedLimit(3), hasLoad=>hasLoad4, load=>load4, Q=> mapDisplayMin2);
	
	contadorHour1: contador4Bits
	port map(clock=>reachedLimit(3), outReachedNine=>reachedLimit(4), hasLoad=>hasLoad5, load=>load5, Q=> mapDisplayHour1);
	
	contadorHour2: contador3Bits
	port map(clock=>reachedLimit(4), reachedFive=>reachedLimit(5), hasLoad=>hasLoad6, load=>load6, Q=> mapDisplayHour2);
	
	DisplaySeg1: Seg7
	port map(entrada=> mapDisplaySeg1, display=> showDisplaySeg1);
	
	DisplaySeg2: Seg7
	port map(entrada=> mapDisplaySeg2, display=> showDisplaySeg2);
	
	DisplayMin1: Seg7
	port map(entrada=> mapDisplayMin1, display=> showDisplayMin1);
	
	DisplayMin2: Seg7
	port map(entrada=> mapDisplayMin2, display=> showDisplayMin2);
	
	DisplayHour1: Seg7
	port map(entrada=> mapDisplayHour1, display=> showDisplayHour1);
	
	DisplayHour2: Seg7
	port map(entrada=> mapDisplayHour2, display=> showDisplayHour2);
	
	
	
end control;		
