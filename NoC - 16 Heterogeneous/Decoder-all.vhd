
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:29:20 09/20/2016 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Decoder is
	port(
	    	data_in: in std_logic_vector(0 to 39);
			data_out: out std_logic_vector(0 to 15);
			--vscb: out std_logic_vector(0 to 5);
			data_2er: out std_logic_vector(0 to 1)
			);
end Decoder;

architecture hamming of Decoder is
begin
	process(data_in)
		variable scb0: std_logic_vector(0 to 15);
		variable scb: std_logic_vector(0 to 5);
		variable vetcb: std_logic;
		variable doubleer: std_logic_vector(0 to 1);
	begin
	
		scb0(0 to 15):=data_in(0 to 15);
		scb(0):=data_in(0) xor data_in(1) xor data_in(3) xor data_in(4) xor data_in(6) xor data_in(8) xor data_in(10) xor data_in(11) xor data_in(13) xor data_in(15) xor data_in(16); 
		scb(1):=data_in(0) xor data_in(2) xor data_in(3) xor data_in(5) xor data_in(6) xor data_in(9) xor data_in(10) xor data_in(12) xor data_in(13) xor data_in(17); 
		scb(2):=data_in(1) xor data_in(2) xor data_in(3) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10) xor data_in(14) xor data_in(15) xor data_in(18); 
		scb(3):=data_in(4) xor data_in(5) xor data_in(6) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10) xor data_in(19); 
		scb(4):=data_in(11) xor data_in(12) xor data_in(13) xor data_in(14) xor data_in(15) xor data_in(20);
		scb(5):=data_in(0) xor data_in(1) xor data_in(2) xor data_in(3) xor data_in(4) xor data_in(5) xor data_in(6) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10) xor data_in(11) xor data_in(12) xor data_in(13) xor data_in(14) xor data_in(15) xor data_in(16) xor data_in(17) xor data_in(18) xor data_in(19) xor data_in(20) xor data_in(21); 
		
		if((scb(0 to 4) /= "00000") and scb(5) = '0')
		then
			data_out <= "0000000000000000";
			data_2er <= "01";
			--vscb <= scb;
		else
			case (scb) is
				when "110001" => scb0(0):=not scb0(0);
				when "101001" => scb0(1):=not scb0(1);
				when "011001" => scb0(2):=not scb0(2);
				when "111001" => scb0(3):=not scb0(3);
				when "100101" => scb0(4):=not scb0(4);
				when "010101" => scb0(5):=not scb0(5);
				when "110101" => scb0(6):=not scb0(6);
				when "001101" => scb0(7):=not scb0(7);
				when "101101" => scb0(8):=not scb0(8);
				when "011101" => scb0(9):=not scb0(9);
				when "111101" => scb0(10):=not scb0(10);
				when "100011" => scb0(11):=not scb0(11);
				when "010011" => scb0(12):=not scb0(12);
				when "110011" => scb0(13):=not scb0(13);
				when "001011" => scb0(14):=not scb0(14);
				when "101011" => scb0(15):=not scb0(15);
				when "000000" => scb0:=scb0;
				when others => scb0:= "0000000000000000";
			end case;
			data_out <= scb0;
			data_2er <= "00";
			--vscb <= scb;
		end if;
		
	end process;
	
end hamming;

architecture clc of Decoder is
type arraysignal is array(0 to 4) of std_logic_vector(0 to 7);
type arraylinsin is array(0 to 4) of std_logic_vector(0 to 2);
begin 
	process (data_in)
	variable signals : arraysignal;
	variable linsin : arraylinsin;
	variable colsin : std_logic_vector( 0  to 7);
	variable spl : std_logic_vector(0 to 4);
	variable j : INTEGER range 0 to 7;
	variable a : INTEGER range 0 to 4;
	variable numlinsin : INTEGER range 0 to 4;
	begin		
	-----------------------------------------cálculo de síndromes--------------------------------------
		numlinsin := 0;
		for j in 0 to 7 loop
			signals(0)(j):= data_in(j);
			signals(1)(j):= data_in(j+8);
			signals(2)(j):= data_in(j+16);
			signals(3)(j):= data_in(j+24);
			signals(4)(j):= data_in(j+32);
			colsin(j) := ( ( ( ( signals(0)(j) xor signals(1)(j) )  xor signals(2)(j) )  xor signals(3)(j) )  xor signals(4)(j) ) ;
		end loop;
		for j in 0 to 4 loop
			linsin(j)(0) := ( ( ( signals(j)(4 ) xor signals(j)(1 ) )  xor signals(j)(2 ) )  xor signals(j)(3 ) ) ;
			linsin(j)(1) := ( ( ( signals(j)(5 ) xor signals(j)(0 ) )  xor signals(j)(2 ) )  xor signals(j)(3 ) ) ;
			linsin(j)(2) := ( ( ( signals(j)(6 ) xor signals(j)(0 ) )  xor signals(j)(1 ) )  xor signals(j)(3 ) ) ;
			spl(j) := ( ( ( ( ( ( signals(j)(1 ) xor signals(j)(2 ) )  xor signals(j)(7 ) )  xor signals(j)(3 ) )  xor signals(j)(6 ) )  xor signals(j)(5 ) )  xor signals(j)(4 ) xor signals(j)(0) ) ; 
			if((linsin(j) /= "000") or (spl(j)/='0'))
			then
				numlinsin := numlinsin + 1;
			end if;
		end loop;
		-------------------------------------correção de linhas---------------------------------
		for a in 0 to 3 loop 
			if  (linsin(a)(0 to 2)/="000") and(numlinsin=1)
			then 
			report "caso 3a"; -- caso impar 111 correção por sp bits 
				for j in 0 to 7 loop
						if ( ( colsin(j) /= '0' )  ) then 
							 signals(a)(j) := (  not signals(a)(j) ) ;
						end if;
				end loop;
			end if;
			if (linsin(a)(0 to 2)="000") and(spl(a)='1')
			then 
			report "caso 3a"; -- caso impar 111 correção por sp bits 
				for j in 0 to 7 loop
						if ( ( colsin(j) /= '0' )  ) then 
							 signals(a)(j) := (  not signals(a)(j) ) ;
						end if;
				end loop;
			end if;			
			if ( linsin(a)  /= "000"  ) 
			then
				if (spl(a)= '0' )
				then
					for j in 0 to 7 loop
						if  ( colsin(j) = '1' ) then 
							 signals(a)(j) :=   not signals(a)(j)  ;
						end if;
					end loop;
				end if;
				if(spl(a)='1')
				then
					case (linsin(a)) is 
						 when "111"  => 
							  signals(a)(3 ) := (  not signals(a)(3 ) ) ;
						 when "110"  => 
							  signals(a)(2 ) := (  not signals(a)(2 ) ) ;
						 when "101"  => 
							  signals(a)(1 ) := (  not signals(a)(1 ) ) ;
						 when "100"  => 
							  signals(a)(4 ) := (  not signals(a)(4 ) ) ;
						 when "011"  => 
							  signals(a)(0 ) := (  not signals(a)(0 ) ) ;
						 when "010"  => 
							  signals(a)(5 ) := (  not signals(a)(5 ) ) ;
						 when "001"  => 
							  signals(a)(6 ) := (  not signals(a)(6 ) ) ;
						 when  others  => 
							  signals(a) := signals(a);
					end case;
				end if;
			end if;
		end loop;
	data_out <= signals(0)(0 to 3) & signals(1)(0 to 3) & signals(2)(0 to 3) & signals(3)(0 to 3) ;
	end process;
end clc;

architecture  matrix of Decoder is

begin
	process(data_in) 
		variable signal1 : std_logic_vector(0 to 6);
		variable signal2 : std_logic_vector(0 to 6);
		variable signal3 : std_logic_vector(0 to 6);
		variable signal4 : std_logic_vector(0 to 6);
		variable signal5 : std_logic_vector(0 to 3);
		variable linsin1 : std_logic_vector( 0  to 2);
		variable linsin2 : std_logic_vector( 0  to 2);
		variable linsin3 : std_logic_vector( 0  to 2);
		variable linsin4 : std_logic_vector( 0  to 2);
		variable vetlinsin: std_logic_vector(0 to 7);
		variable colsin : std_logic_vector(0 to 3);
		variable colsin2 : std_logic_vector(0 to 3);		
		variable j : INTEGER range 0 to 2;
		variable numcolsin : INTEGER range 0 to 2;
		variable numlinsin : INTEGER range 0 to 2;
		variable a : std_logic;
		variable b : INTEGER;
		variable numcolsin2: INTEGER RANGE 0 TO 7;
		variable erroparidade: INTEGER RANGE 0 TO 2;
		variable val: INTEGER RANGE 0 to 2;
		variable vetoroi: std_logic_vector(0 to 6);
		begin
			for j in 0 to 6 loop
				signal1(j):= data_in(j);
				signal2(j):= data_in(j+7);
				signal3(j):= data_in(j+14);
				signal4(j):= data_in(j+21);			
			end loop;
			for j in 0 to 3 loop
				signal5(j):= data_in(j+28);
			end loop;
			numcolsin := 0;
			numlinsin := 0;
			for j in 0 to 3 loop
				colsin(j) := ( ( ( ( signal1(j) xor signal2(j) )  xor signal3(j) )  xor signal4(j) )  xor signal5(j) ) ;
			end loop;
			linsin1(0) := ( ( ( signal1(4 ) xor signal1(1 ) )  xor signal1(2 ) )  xor signal1(3 ) ) ;
			linsin1(1) := ( ( ( signal1(5 ) xor signal1(0 ) )  xor signal1(2 ) )  xor signal1(3 ) ) ;
			linsin1(2) := ( ( ( signal1(6 ) xor signal1(0 ) )  xor signal1(1 ) )  xor signal1(3 ) ) ;

			linsin2(0) := ( ( ( signal2(4 ) xor signal2(1 ) )  xor signal2(2 ) )  xor signal2(3 ) ) ;
			linsin2(1) := ( ( ( signal2(5 ) xor signal2(0 ) )  xor signal2(2 ) )  xor signal2(3 ) ) ;
			linsin2(2) := ( ( ( signal2(6 ) xor signal2(0 ) )  xor signal2(1 ) )  xor signal2(3 ) ) ;

			linsin3(0) := ( ( ( signal3(4 ) xor signal3(1 ) )  xor signal3(2 ) )  xor signal3(3 ) ) ;
			linsin3(1) := ( ( ( signal3(5 ) xor signal3(0 ) )  xor signal3(2 ) )  xor signal3(3 ) ) ;
			linsin3(2) := ( ( ( signal3(6 ) xor signal3(0 ) )  xor signal3(1 ) )  xor signal3(3 ) ) ;

			linsin4(0) := ( ( ( signal4(4 ) xor signal4(1 ) )  xor signal4(2 ) )  xor signal4(3 ) ) ;
			linsin4(1) := ( ( ( signal4(5 ) xor signal4(0 ) )  xor signal4(2 ) )  xor signal4(3 ) ) ;
			linsin4(2) := ( ( ( signal4(6 ) xor signal4(0 ) )  xor signal4(1 ) )  xor signal4(3 ) ) ;
			vetlinsin := "00000000";
			for j in 0 to 3 loop
				if (colsin(j) /= '0')
				then
					numcolsin:= 1 + numcolsin;
				end if;
			end loop;
			if(linsin1 /= "000")
			then
				vetlinsin(0):= '1';
				numlinsin := 1 + numlinsin;
			end if;
			if(linsin2 /= "000")
			then
				vetlinsin(1):= '1';
				numlinsin := 1 + numlinsin;
			end if;
			if(linsin3 /= "000")
			then
				vetlinsin(2):= '1';
				numlinsin := 1 + numlinsin;
			end if;
			if(linsin4 /= "000")
			then
				vetlinsin(3):= '1';
				numlinsin := 1 + numlinsin;
			end if;
			--- Caso 1: Verificação se as sindromes são iguais a 0
			if(numlinsin = 0 and numcolsin = 0)
			then
				data_out <=(signal1(0 to 3) & signal2(0 to 3) & signal3(0 to 3) & signal4(0 to 3)); 
			end if;
			--- Caso 2: ((numlinsin>1) and (numcolsin=0)) isso só será possível havendo erros simples em uma mesma coluna ou erros simples em colunas diferentes fora dos data bits 
			if((numlinsin>1) and (numcolsin=0))
			then
			report "caso2";
				if(vetlinsin(0)='1')
				then
					erroparidade := 0;
					numcolsin2 :=0;
					case(linsin1) is
					when "111" =>
						vetoroi:="0001000";
					when "110" =>
						vetoroi:="0010000";
					when "101" =>
						vetoroi:="0100000";	
					when "011" =>
						vetoroi:="1000000";
					when others =>
						vetoroi:="0000000";
					end case;
					signal1 := vetoroi xor signal1;
				end if;
				-----linha nova
				if(vetlinsin(1)='1')
				then
					erroparidade := 0;
					numcolsin2 :=0;
					case(linsin2) is
					when "111" =>
						vetoroi:="0001000";
					when "110" =>
						vetoroi:="0010000";
					when "101" =>
						vetoroi:="0100000";	
					when "011" =>
						vetoroi:="1000000";
					when others =>
						vetoroi:="0000000";
					end case;
					signal2 := vetoroi xor signal2;
				end if;
				-----linha nova
				if(vetlinsin(2)='1')
				then
					erroparidade := 0;
					numcolsin2 :=0;
					case(linsin3) is
					when "111" =>
						vetoroi:="0001000";
					when "110" =>
						vetoroi:="0010000";
					when "101" =>
						vetoroi:="0100000";	
					when "011" =>
						vetoroi:="1000000";
					when others =>
						vetoroi:="0000000";
					end case;
					signal3 := vetoroi xor signal3;
				end if;
				-----linha nova
				if(vetlinsin(3)='1')
				then
					erroparidade := 0;
					numcolsin2 :=0;
					case(linsin4) is
					when "111" =>
						vetoroi:="0001000";
					when "110" =>
						vetoroi:="0010000";
					when "101" =>
						vetoroi:="0100000";	
					when "011" =>
						vetoroi:="1000000";
					when others =>
						vetoroi:="0000000";
					end case;
					signal4 := vetoroi xor signal4;
				end if;
				-----linha nova
				-----linha nova			
--			end if; --- fim do primeiro case	
			--CASO 3.1((numcolsin = 1) and (numlinsin =0)) siginifica que não há erro nas linhas			
			elsif((numlinsin=0) and (numcolsin>0))
			then
			data_out <=(signal1(0 to 3) & signal2(0 to 3) & signal3(0 to 3) & signal4(0 to 3)); 
			--Caso 3.1: numlinsin=1 e numcolsin=1 significa a ocorrencia ou de 1 erro simples, ou erro duplo entre os data bits e checkbits de uma linha
			elsif((numlinsin/=0) and (numcolsin/=0))
			then	
				report "caso3";
				if((numlinsin=1) and (numcolsin=1))--Caso especial para a ultima linha da matriz
				then
					if(vetlinsin(3)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin4) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal4 := vetoroi xor signal4;
						for j in 0 to 3 loop -- análise caso seja erro duplo
							colsin2(j) := ( ( ( ( signal1(j) xor signal2(j) )  xor signal3(j) )  xor signal4(j) )  xor signal5(j)) ;
							if((vetoroi(j)='1')and(colsin2(j)='1'))
							then
								erroparidade := 1;
							end if;
							numcolsin2 := numcolsin2 + 1;						
							end loop;
						if(numcolsin2>0) and (erroparidade=0)
						then
							for j in 0 to 3 loop
								signal4(j) := not signal4(j);
							end loop;
						end if;
					elsif(vetlinsin(3)='0')
					then
						if(linsin1 /= "000")
						then
							signal1(0 to 3):= signal1(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin2 /= "000")
						then
							signal2(0 to 3):= signal2(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin3 /= "000")
						then
							signal3(0 to 3):= signal3(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin4 /= "000")
						then
							signal4(0 to 3):= signal4(0 to 3) xor colsin(0 to 3);
						end if;
					end if;
			--CASO 4 numsp>1 &&numsc==1 -> dois erros em uma linha.Corrige pelo método		
				elsif((numcolsin>1) and(numlinsin=1))
				then
				report "caso4";
					if(vetlinsin(3)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin4) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal4 := vetoroi xor signal4;
						for j in 0 to 3 loop -- análise caso seja erro duplo
							colsin2(j) := ( ( ( ( signal1(j) xor signal2(j) )  xor signal3(j) )  xor signal4(j) )  xor signal5(j)) ;
							if((vetoroi(j)='1')and(colsin2(j)='1'))
							then
								erroparidade := 1;
							end if;
							numcolsin2 := numcolsin2 + 1;						
							end loop;
						if(numcolsin2>=2) 
						then
							for j in 0 to 3 loop
								signal4(j) := not signal4(j);
							end loop;
						end if;
					elsif(vetlinsin(3)='0')
					then
					report "entrou certo";
						if(linsin1 /= "000")
						then
							signal1(0 to 3):= signal1(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin2 /= "000")
						then
							signal2(0 to 3):= signal2(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin3 /= "000")
						then
							signal3(0 to 3):= signal3(0 to 3) xor colsin(0 to 3);
						end if;
						if(linsin4 /= "000")
						then
							signal4(0 to 3):= signal4(0 to 3) xor colsin(0 to 3);
						end if;
					end if;
				elsif((numcolsin>=1) and(numlinsin>=1)) --Caso 5: Multiplos erros em linhas diferentes corrigida por hamming
				then
				report "caso5";
					if(vetlinsin(0)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin1) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal1 := vetoroi xor signal1;
					end if;
					-----linha nova
					if(vetlinsin(1)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin2) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal2 := vetoroi xor signal2;
					end if;
					-----linha nova
					if(vetlinsin(2)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin3) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal3 := vetoroi xor signal3;
					end if;
					-----linha nova
					if(vetlinsin(3)='1')
					then
						erroparidade := 0;
						numcolsin2 :=0;
						case(linsin4) is
						when "111" =>
							vetoroi:="0001000";
						when "110" =>
							vetoroi:="0010000";
						when "101" =>
							vetoroi:="0100000";	
						when "011" =>
							vetoroi:="1000000";
						when others =>
							vetoroi:="0000000";
						end case;
						signal4 := vetoroi xor signal4;
					end if;
				end if;
			end if;
		data_out <=(signal1(0 to 3) & signal2(0 to 3) & signal3(0 to 3) & signal4(0 to 3)); 
	end process;
end matrix;


