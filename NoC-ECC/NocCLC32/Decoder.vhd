----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:03:54 09/21/2016 
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
USE ieee.std_logic_1164.ALL;
entity Decoder is
	port (
		  data_in: in std_logic_vector( 0  to 71 );
        data_out :  out std_logic_vector( 0  to 31  )
    );
end Decoder;


architecture Behavioral of Decoder is
type arraysignal is array(0 to 8) of std_logic_vector(0 to 7);
type arraylinsin is array(0 to 8) of std_logic_vector(0 to 2);
begin 
	process (data_in)
	variable signals : arraysignal;
	variable linsin : arraylinsin;
	variable colsin : std_logic_vector( 0  to 7);
	variable spl : std_logic_vector(0 to 8);
	variable j : INTEGER range 0 to 7;
	variable a : INTEGER range 0 to 7;
	variable numlinsin : INTEGER range 0 to 8;
	begin		
	-----------------------------------------cálculo de síndromes--------------------------------------
		numlinsin := 0;
		for j in 0 to 7 loop
			signals(0)(j):= data_in(j);
			signals(1)(j):= data_in(j+8);
			signals(2)(j):= data_in(j+16);
			signals(3)(j):= data_in(j+24);
			signals(4)(j):= data_in(j+32);
			signals(5)(j):= data_in(j+40);
			signals(6)(j):= data_in(j+48);
			signals(7)(j):= data_in(j+56);
			signals(8)(j):= data_in(j+64);
			colsin(j) := ( ( ( ( signals(0)(j) xor signals(1)(j) )  xor signals(2)(j) )  xor signals(3)(j) )  xor signals(4)(j) xor signals(5)(j) xor signals(6)(j) xor signals(7)(j) xor signals(8)(j) ) ;
		end loop;
		for j in 0 to 8 loop
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
		for a in 0 to 7 loop 
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
	data_out <= signals(0)(0 to 3) & signals(1)(0 to 3) & signals(2)(0 to 3) & signals(3)(0 to 3) & signals(4)(0 to 3) & signals(5)(0 to 3) & signals(6)(0 to 3) & signals(7)(0 to 3) ;
	end process;
end;
