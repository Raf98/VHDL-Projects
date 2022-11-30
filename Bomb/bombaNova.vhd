library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

----------------------------------------declaracao de I/O--------------------------------------------

entity bombaNova is
port(
	fios: in std_logic_vector(4 downto 0);							--fios da bomba
	displaySeg1: out std_logic_vector(6 downto 0); 				--sinal de contagem do display da unidade de segundo
	displaySeg2: out std_logic_vector(6 downto 0); 				--sinal de contagem do display da dezena de segundo
	displayMin1: out std_logic_vector(6 downto 0); 				--sinal de contagem do display da unidade de minuto
	displayMin2: out std_logic_vector(6 downto 0); 				--sinal de contagem do display da dezena de minuto
	displayCod: out std_logic_vector(6 downto 0);				--saida do codigo de desarme para o display
	displayAux: out std_logic_vector(6 downto 0);				--saida auxiliar para o display para exbir defuse ou denied
	codEntrada: in std_logic_vector(3 downto 0); 				--codigo de entrada dos switches
	setInDesarme:in std_logic;                     				--ativa o recebimento de codigos para desarme da bomba duarnte a contagem
	setDesarme:in std_logic;                     				--ativa o recebimento do codigo de desarme da bomba
	clock: in std_logic;								 					--clock da placa
	setCont : in std_logic;							 					--seta o inico da contagem regressiva
	selCont: in std_logic_vector(1 downto 0); 	 				--o segundo ou minuto a ser inserido atraves dos switches
	desarmar:out std_logic;												--desarma a bomba
	explodiu:out std_logic;												--explode a bomba
	selOp:in std_logic_vector(1 downto 0)  	 					--seleciona a operacao a ser realizada
); end bombaNova;


---------------------------------construcao do comportamento----------------------------

architecture boom of bombaNova is

---------------------------------componentes---------------------------------

component Divider is
	 port (
		 CLK: 			in STD_LOGIC;
		 COUT: 			out STD_LOGIC;
		 COUT2: 			out STD_LOGIC;
		 COUT4: 			out STD_LOGIC
		 );
 end component;
 
component counter3bits is
port
(
		clock,hasLoad: in std_logic;
		zerou: 			out std_logic;
		load: 			in std_logic_vector(3 downto 0);
		Q: 				out std_logic_vector(3 downto 0)
);
end component;
	
component muxbomba is
port(
		sel: 				in std_logic_vector(1 downto 0);
		desliga,regr,regr2,regr4: std_logic;
		c: 				out std_logic
);
end component;

component regis4 is
port(
		D: 				in std_logic_vector(3 downto 0);
		clock,clear: 	in std_logic;
		load: 			in std_logic;
		Q: 				out std_logic_vector(3 downto 0)
);
end component;

component Seg7 is 
port
(
		entrada: 		in std_logic_vector(3 downto 0);
		display: 		out std_logic_vector(6 downto 0)
);
end component;

component counter4bits is 
port
(
		clock,hasLoad: in std_logic;
		zerou: 			out std_logic;
		load: 			in std_logic_vector(3 downto 0);
		Q: 				out std_logic_vector(3 downto 0)
);
end component;


-------------------------------------------------Sinais do circuito------------------------------------

	signal regressiva4: std_logic;										--sinal de clock multiplicado por 2
	signal regressiva2: std_logic;										--sinal de clock multiplicado por 4
	signal regressiva: std_logic;											--sinal de clock normal
	signal omegaclock: std_logic;											--sinal de clock do contador regressivo
	
	signal inDisplaySeg1: std_logic_vector(3 downto 0); 			--sinal de entrada no diaplsy do seg1
	signal inDisplaySeg2: std_logic_vector(3 downto 0);			--sinal de entrada no display do seg2
	signal inDisplayMin1: std_logic_vector(3 downto 0);			--sinal de entrada no display do min1
	signal inDisplayMin2: std_logic_vector(3 downto 0);			--sinal de entrada no display do min2
	signal inDisplayCod: std_logic_vector(3 downto 0);				--sinal de entrada no display do codigo
	signal inDisplayAux: std_logic_vector(3 downto 0);				--sinal de entrada no display do auxiliar
	signal sinalSeg1: std_logic_vector(3 downto 0);					--sinal do valor inicial de seg1
	signal sinalSeg2: std_logic_vector(3 downto 0);					--sinal do valor inicial de seg2;
	signal sinalMin1: std_logic_vector(3 downto 0);					--sinal do valor inicial de min1
	signal sinalMin2: std_logic_vector(3 downto 0);					--sinal do valor inicial de min2
	signal setSeg1: std_logic_vector(3 downto 0);					--sinal do valor inicial de seg1
	signal setSeg2: std_logic_vector(3 downto 0);					--sinal do valor inicial de seg2;
	signal setMin1: std_logic_vector(3 downto 0);					--sinal do valor inicial de min1
	signal setMin2: std_logic_vector(3 downto 0);					--sinal do valor inicial de min2
	signal sinalInicioContagem : std_logic_vector(3 downto 0); 	--sinal dos valores iniciais passados pelo push button
	
	signal contaProx1: std_logic;											--flag para mudanca de valores no display2
	signal contaProx2: std_logic;											--flag para mudanca de valores no display3
	signal contaProx3: std_logic;											--flag para mudanca de valores no display4

	signal defuseCode: std_logic_vector(3 downto 0);							-- 
	signal codDesarme: std_logic_vector(3 downto 0); 				--codigo para desarmar a bomba
	signal setContagem: std_logic;							 			--seta a entrada para contagem
	signal codInDesarma: std_logic_vector(3 downto 0);				--codigo de entrada para desarme durante a contagem da bomba
	
	signal saidaContadorSeg1: std_logic_vector(3 downto 0);		--sinal de saida do contador da unidade de segundo
	signal saidaContadorSeg2: std_logic_vector(3 downto 0);		--sinal de saida do contador da dezena de segundo
	signal saidaContadorMin1: std_logic_vector(3 downto 0);		--sinal de saida do contador da unidade de minuto
	signal saidaContadorMin2: std_logic_vector(3 downto 0);		--sinal de saida do contador da dezena de minuto
	
	signal selMuxOp: std_logic_vector(1 downto 0);    				--seleciona a operacao do muxbomba


----------------------------descricao dos processos e port maps---------------------------------
begin

------------------------------------Port Maps---------------------------------------------------

	defuser: regis4
	port map(D=>codEntrada,clock=>clock,load=>setDesarme,clear=>'0',Q=>defuseCode);
	
--	process(clock, selOp, selCont)
		
--		end process;
		
	DiviMaster: Divider														--Divisor de frequencia
	port map(CLK=>clock,COUT=>regressiva,COUT2=>regressiva2,COUT4=>regressiva4);

	mux: muxbomba																--mux para selecao de operacao sobre as saidas do divisor
	port map(desliga=>'0',regr=>regressiva,regr2=>regressiva2,regr4=>regressiva4,sel=> selMuxOp  ,c=>omegaclock);

	guardaSeg1: regis4														--registrador dos valores passados a unidade de segundo
	port map(D=>sinalSeg1,clock=>clock,load=>'1',clear=>'0',Q=>setSeg1);

	contaSeg1: counter4bits -- and setCont								--contador da unidade de segundo
	port map(clock=>omegaclock and setCont, hasLoad=>setContagem, load=>setSeg1, zerou=>contaProx1, Q=>saidaContadorSeg1);
	
--	process(clock,setContagem)																				--assinala os valores aos displays de contador

--	end process;
		
	mostraSeg1: Seg7
	port map(entrada=>inDisplaySeg1,display=>displaySeg1);

	guardaSeg2: regis4														--registrador dos valores passados a dezena de segundo
	port map(D=>sinalSeg2,clock=>clock,load=>'1',clear=>'0',Q=>setSeg2);

	contaSeg2: counter3bits -- and setCont								--contador da dezena de segundo
	port map(clock=>contaProx1, hasLoad=>setContagem, load=>setSeg2, zerou=>contaProx2, Q=>saidaContadorSeg2);
		
	mostraSeg2: Seg7
	port map(entrada=>inDisplaySeg2,display=>displaySeg2);

	guardaMin1: regis4                                          --registrador dos valores passados a unidade de minuto
	port map(D=>sinalMin1,clock=>clock,load=>'1',clear=>'0',Q=>setMin1);						
		
	contaMin1: counter4bits -- and setCont								--contador da unidade de minuto
	port map(clock=>contaProx2, hasLoad=>setContagem, load=>setMin1, zerou=>contaProx3, Q=>saidaContadorMin1);
		
	mostraMin1: Seg7
	port map(entrada=>inDisplayMin1,display=>displayMin1);

	guardaMin2: regis4														--registrador dos valores passados a dezena de minuto
	port map(D=>sinalMin2,clock=>clock,load=>'1',clear=>'0',Q=>setMin2);

	contaMin2: counter4bits -- and setCont								--contador da dezena de minuto
	port map(clock=>contaProx3, hasLoad=>setContagem, load=>setMin2, Q=>saidaContadorMin2);
		
	mostraMin2: Seg7
	port map(entrada=>inDisplayMin2,display=>displayMin2);
	
	mostraCodigo: Seg7						
	port map(entrada=>inDisplayCod,display=>displayCod);
	
	mostraAuxiliar: Seg7
	port map(entrada=>inDisplayAux,display=>displayAux);
	
-------------------------------------------------Processos------------------------------------	
	
	process(clock, selOp, selCont)										--tratamento das entradas de armar ou desarmar
		begin
			if(clock'event AND clock = '1')then
				if(selOp = "00")then											--selOp 00: setar codigo de desarme 
					desarmar<='0';
					explodiu<='0';
					selMuxOp<="01";
					setContagem<='0';
					codDesarme<= defuseCode;--codEntrada;
					elsif(selOp = "01")then                                                                                                                                                       							--selOp 01: setar valores de contagem
						setContagem<= '1';
						sinalInicioContagem<=codEntrada;
						if(selCont = "00" AND setContagem = '1')then sinalSeg1<= sinalInicioContagem;
							elsif(selCont = "01" AND setContagem = '1')then sinalSeg2<= sinalInicioContagem;
								elsif(selCont = "10" AND setContagem = '1')then sinalMin1<= sinalInicioContagem;
									elsif(selCont = "11" AND setContagem = '1')then sinalMin2<= sinalInicioContagem;
						end if;
						elsif(selOp = "10")then								--selOp 10:	testar codigos de desarme 
							setContagem <= '0';
							codInDesarma <= codEntrada;
							if(((codDesarme = codInDesarma)and (setInDesarme = '1')) or (fios(4) = '1'))then    
  								desarmar<='1';									--desarma a bomba
							   selMuxOp<="00";
								
								elsif(fios(1) = '1')then	--setFios
									explodiu<='1';								--explode a bomba pelos fios
									setContagem<='1';
									sinalSeg1<="0000";
									sinalSeg2<="0000";
									sinalMin1<="0000";
									sinalMin2<="0000";
									--selMuxOp<="00";
								
									elsif(fios(2) = '1')then
										selMuxOp<="11";						--coloca em 4x o tempo normal
										
										if(saidaContadorSeg1="0000" and saidaContadorSeg2="0000" and saidaContadorMin1="0000" and saidaContadorMin2="0000")then --explosao
												explodiu<='1';					--bomba explode pela contagem
												setContagem<='1';
												sinalSeg1<="0000";
												sinalSeg2<="0000";
												sinalMin1<="0000";
												sinalMin2<="0000";
												--selMuxOp<="00";
										end if;
								
										elsif(fios(0) = '1')then   --AND setaNovoClock2x = '1'								 
											selMuxOp<="10";					--coloca em 2x o tempo normal
									
											if(saidaContadorSeg1="0000" and saidaContadorSeg2="0000" and saidaContadorMin1="0000" and saidaContadorMin2="0000")then --explosao
												explodiu<='1';					--bomba explode pela contagem
												setContagem<='1';
												sinalSeg1<="0000";
												sinalSeg2<="0000";
												sinalMin1<="0000";
												sinalMin2<="0000";
												--selMuxOp<="00";
											end if;
																

											elsif(saidaContadorSeg1="0000" and saidaContadorSeg2="0000" and saidaContadorMin1="0000" and saidaContadorMin2="0000")then --explosao
												explodiu<='1';					--bomba explode pela contagem
												setContagem<='1';
												sinalSeg1<="0000";
												sinalSeg2<="0000";
												sinalMin1<="0000";
												sinalMin2<="0000";
												
							end if;
							elsif(selOp = "11")then setContagem <= '0';--selOp 11: estado intermediario para chegar a 10	
							elsif(saidaContadorSeg1="0000" and saidaContadorSeg2="0000" and saidaContadorMin1="0000" and saidaContadorMin2="0000")then --explosao
												explodiu<='1';					--bomba explode pela contagem
												setContagem<='1';
												sinalSeg1<="0000";
												sinalSeg2<="0000";
												sinalMin1<="0000";
												sinalMin2<="0000";
				end if;
			end if;
		end process;
		
		
		process(clock,setContagem, setDesarme, codDesarme, codInDesarma, setInDesarme)
		variable count0,count1,count2,count3: integer := 0;		--assinala os valores aos displays de contador
		begin
			if(clock'event and clock = '1') then
				if(setContagem = '0')then
					if(codDesarme /= codInDesarma AND setInDesarme = '1')then			
						inDisplaySeg1<="1110"; --d							--escreve "nied" por certo tempo
						inDisplaySeg2<="1010"; --e
						indisplayMin1<="0001"; --i
						indisplayMin2<="1011"; --n
						
						count0 := count0 + 1;
						if(count0 = 100)then
							count0:=0;
							count1 := count1 + 1;
							elsif(count1 = 100)then
								count1:=0;
								count2:= count2 + 1;
								elSif(count2 = 100)then 
									count2:=0;
									count3 := count3 + 1;
									elsif(count3 = 2)then
										count3:=0;
										inDisplaySeg1<=saidaContadorSeg1;--volta a mostrar a contagem
										inDisplaySeg2<=saidaContadorSeg2;
										indisplayMin1<=saidaContadorMin1;
										indisplayMin2<=saidaContadorMin2;
						end if;
										
					elsif((codDesarme = codInDesarma AND setInDesarme = '1') or (fios(4) = '1'))then                                                                                                                                                                                             		
																					--escreve "fuse" por certo tempo
						inDisplaySeg1<="1010"; --e
						inDisplaySeg2<="0101"; --S
						indisplayMin1<="1101"; --u
						indisplayMin2<="1100"; --f
							
						else
							inDisplaySeg1<=saidaContadorSeg1;
							inDisplaySeg2<=saidaContadorSeg2;
							indisplayMin1<=saidaContadorMin1;
							indisplayMin2<=saidaContadorMin2;
					end if;	
				else
					inDisplaySeg1<=setSeg1;
					inDisplaySeg2<=setSeg2;
					indisplayMin1<=setMin1;
					indisplayMin2<=setMin2;
				end if;
			end if;
		end process;
		
		process(clock, setDesarme, codDesarme, codInDesarma, setInDesarme)
		variable count0,count1,count2,count3: integer := 0;	--assinala os valores aos displays do codigo e auxiliar
		begin 
			if(clock'event and clock = '1') then
				if(setDesarme = '1')then
					inDisplayCod<=defuseCode;
					inDisplayAux<="1111";
				else 
					if(setContagem = '0')then
						if(codDesarme /= codInDesarma AND setInDesarme = '1')then	
							inDisplayCod<="1110"; --d					--escreve "de" por certo tempo
							inDisplayAux<="1010"; --e
						
							count0 := count0 + 1;
							if(count0 = 100)then
								count0:=0;
								count1 := count1 + 1;
								elsif(count1 = 100)then
									count1:=0;
									count2:= count2 + 1;
									elsif(count2 = 100)then 
										count2:=0;
										count3 := count3 + 1;
										elsif(count3 = 2)then
											count3:=0;
											inDisplayCod<="1111"; 		--desliga os leds dos displays de codigo e auxiliar
											inDisplayAux<="1111"; 
						
							end if;
										
						elsif((codDesarme = codInDesarma AND setInDesarme = '1') or (fios(4) = '1'))then			
																				--escreve "de" por certo tempo
							inDisplayCod<="1110"; --d
							inDisplayAux<="1010"; --e
							
							else
								inDisplayCod<="1111"; 
								inDisplayAux<="1111"; 
						end if;	
						else
							inDisplayCod<="1111"; 
							inDisplayAux<="1111";
					
					end if;
				end if;
			end if;
		end process;


	end boom;