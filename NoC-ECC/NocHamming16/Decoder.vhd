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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
	port(
	    	data_in: in std_logic_vector(0 to 21);
			data_out: out std_logic_vector(0 to 15);
			--vscb: out std_logic_vector(0 to 5);
			data_2er: out std_logic_vector(0 to 1)
			);
end Decoder;

architecture Behavioral of Decoder is
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
	
end Behavioral;

