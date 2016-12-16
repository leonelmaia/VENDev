----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:08:01 07/09/2016 
-- Design Name: 
-- Module Name:    EncodeCLC - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Encoder is
	port ( 
			data_in : in std_logic_vector(0 to 31);
			data_out: out std_logic_vector(0 to 71)
			);
end Encoder;

architecture Behavioral of Encoder is
begin
	process(data_in)
		variable checkbits1: std_logic_vector(0 to 2);
		variable checkbits2: std_logic_vector(0 to 2);
		variable checkbits3: std_logic_vector(0 to 2);
		variable checkbits4: std_logic_vector(0 to 2);
		variable checkbits5: std_logic_vector(0 to 2);
		variable checkbits6: std_logic_vector(0 to 2);
		variable checkbits7: std_logic_vector(0 to 2);
		variable checkbits8: std_logic_vector(0 to 2);
		variable parcoluna: std_logic_vector(0 to 7);
		variable parlinha: std_logic_vector(0 to 7);
		variable linha: integer;
	begin
		-- 1° Passo: Cálculo de checkbits
		--
		linha:=0;
		checkbits1(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits1(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits1(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=1;
		checkbits2(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits2(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits2(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=2;
		checkbits3(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits3(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits3(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=3;
		checkbits4(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits4(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits4(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=4;
		checkbits5(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits5(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits5(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=5;
		checkbits6(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits6(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits6(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=6;
		checkbits7(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits7(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits7(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		--
		linha:=7;
		checkbits8(0):= data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits8(1):= data_in(0+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4);
		checkbits8(2):= data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(3+linha*4);
		-- Juntando as partes codificadas
		--2° Passo: Cálculo de paridade da linha
			linha:=0;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits1(0) xor checkbits1(1) xor checkbits1(2);
			linha:=1;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits2(0) xor checkbits2(1) xor checkbits2(2);
			linha:=2;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits3(0) xor checkbits3(1) xor checkbits3(2);
			linha:=3;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits4(0) xor checkbits4(1) xor checkbits4(2);
			linha:=4;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits5(0) xor checkbits5(1) xor checkbits5(2);
			linha:=5;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits6(0) xor checkbits6(1) xor checkbits6(2);
			linha:=6;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits7(0) xor checkbits7(1) xor checkbits7(2);
			linha:=7;
			parlinha(linha):=data_in(0+linha*4) xor data_in(1+linha*4) xor data_in(2+linha*4) xor data_in(3+linha*4) xor checkbits8(0) xor checkbits8(1) xor checkbits8(2);

		--3° Passo: Cálculo de paridade da coluna
			linha:=0;
			parcoluna(linha):=data_in(0+linha) xor data_in(4+linha) xor data_in(8+linha) xor data_in(12+linha) xor data_in(16+linha) xor data_in(20+linha) xor data_in(24+linha) xor data_in(28+linha);
			linha:=1;
			parcoluna(linha):=data_in(0+linha) xor data_in(4+linha) xor data_in(8+linha) xor data_in(12+linha) xor data_in(16+linha) xor data_in(20+linha) xor data_in(24+linha) xor data_in(28+linha);
			linha:=2;
			parcoluna(linha):=data_in(0+linha) xor data_in(4+linha) xor data_in(8+linha) xor data_in(12+linha) xor data_in(16+linha) xor data_in(20+linha) xor data_in(24+linha) xor data_in(28+linha);
			linha:=3;
			parcoluna(linha):=data_in(0+linha) xor data_in(4+linha) xor data_in(8+linha) xor data_in(12+linha) xor data_in(16+linha) xor data_in(20+linha) xor data_in(24+linha) xor data_in(28+linha);
			linha:=4;
			parcoluna(linha):=checkbits1(0) xor checkbits2(0) xor checkbits3(0) xor checkbits4(0)  xor checkbits5(0) xor checkbits6(0) xor checkbits7(0) xor checkbits8(0);
			linha:=5;
			parcoluna(linha):=checkbits1(1) xor checkbits2(1) xor checkbits3(1) xor checkbits4(1) xor checkbits5(1) xor checkbits6(1) xor checkbits7(1) xor checkbits8(1);
			linha:=6;
			parcoluna(linha):=checkbits1(2) xor checkbits2(2) xor checkbits3(2) xor checkbits4(2) xor checkbits5(2) xor checkbits6(2) xor checkbits7(2) xor checkbits8(2);
			linha:=7;
			parcoluna(linha):=parlinha(0) xor parlinha(1) xor parlinha(2) xor parlinha(3) xor parlinha(4) xor parlinha(5) xor parlinha(6) xor parlinha(7);

		data_out <=(data_in(0 to 3) & checkbits1 & parlinha(0) & 
		data_in(4 to 7) & checkbits2 & parlinha(1) & 
		data_in(8 to 11)& checkbits3 & parlinha(2) & 
		data_in(12 to 15) & checkbits4 & parlinha(3) & 
		data_in(16 to 19) & checkbits5 & parlinha(4) & 
		data_in(20 to 23) & checkbits6 & parlinha(5) & 
		data_in(24 to 27) & checkbits7 & parlinha(6) & 
		data_in(28 to 31) & checkbits8 & parlinha(7) & 
		parcoluna);
	end process;
end Behavioral;

