library ieee;
use ieee.std_logic_1164.all;


entity Matrix is 
generic(num:    integer:=32);
port
(
    a,b :   in std_logic_vector(num-1 downto 0);
    m :     out std_logic_vector(num*2-1 downto 0)
);
end Matrix;

architecture behavior of Matrix is

    signal andPorts,s:  std_logic_vector( ( (num)*(num) - 1 ) downto 0 );
	 --signal s:  			std_logic_vector( (num)*(num-3) - 1 downto 0 );
    signal cOutInternal:std_logic_vector( (num)*(num) downto 0 );
    signal cOut:        std_logic_vector( num downto 0 );


    component FullAdder is
        port
        (
            cin, a, b: 	IN STD_LOGIC;
	        s, cout: 	OUT STD_LOGIC
        );
    end component;


    begin

        andGen:
        for i in 0 to num-1 generate 

			andGen2:
            for j in 0 to num-1 generate

                andPorts(j+num*i) <= a(i) and b(j); 

            end generate;

        end generate;


        --Primeira AND -> mapeada direto para a saida

        m(0) <= andPorts(0);


        -- Primeiro bloco somador -> mapeado diferentemente dos outros 

        cOutInternal(0) <= '0';

        cOut(0) <= '0';

        FAGen0:

        for i in 0 to num-2 generate

            FA:     FullAdder

            port map( cOutInternal(i), andPorts(num+i) , andPorts(i+1), s(i), cOutInternal(i+1));

        end generate;

        FA:     FullAdder

        port map( cOutInternal(num-1), andPorts(num+num-1) , cOut(0), s(num-1), cOut(1));


        --cOut(1) <= cOutInternal(num);
		  cOutInternal(num) <= '0';

        m(1) <= s(0);

        FACount:
        
        for i in 1 to num-2 generate

            FAGen:

            for j in 0 to num-2 generate

                FA:     FullAdder

                port map( cOutInternal(num*i+j), andPorts(num*(i+1)+j) , s(num*(i-1)+j+1), s(num*i+j), cOutInternal(num*i+j+1));

            end generate;

            FA:     FullAdder

            port map( cOutInternal(num*i+num-1), andPorts(num*(i+1)+num-1) , cOut(i), s(num*i+num-1), cOut(i+1) );

            --cOut(i+1) <= cOutInternal(num*i+num);
				
				cOutInternal(num*i+num) <= '0';

            m(i+1) <= s(num*i);

        end generate;

        outputGen:

        for i in 0 to num-2 generate

            m(num+i) <= s( num*(num-2) + i +1 );

        end generate;

        m(2*num-1) <= cOut(num-1);
        --s(num*(num-1) + num-1)

        


    end behavior;