----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:03 09/20/2016 
-- Design Name: 
-- Module Name:    Encoder - Behavioral 
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

entity Encoder is
	port(
			data_in: in std_logic_vector(0 to 15);
			data_out: out std_logic_vector(0 to 21) 
			);
end Encoder;

architecture Behavioral of Encoder is

begin
	process(data_in)
		variable cb0: std_logic_vector(0 to 15);
		variable cb1: std_logic;
		variable cb2: std_logic;
		variable cb3: std_logic;
		variable cb4: std_logic;
		variable cb5: std_logic;
		variable cb6: std_logic;
	begin
	cb0(0 to 15):=data_in(0 to 15);
	cb1:=data_in(0) xor data_in(1) xor data_in(3) xor data_in(4) xor data_in(6) xor data_in(8) xor data_in(10) xor data_in(11) xor data_in(13) xor data_in(15); 
	cb2:=data_in(0) xor data_in(2) xor data_in(3) xor data_in(5) xor data_in(6) xor data_in(9) xor data_in(10) xor data_in(12) xor data_in(13); 
	cb3:=data_in(1) xor data_in(2) xor data_in(3) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10) xor data_in(14) xor data_in(15); 
	cb4:=data_in(4) xor data_in(5) xor data_in(6) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10); 
	cb5:=data_in(11) xor data_in(12) xor data_in(13) xor data_in(14) xor data_in(15);
	cb6:=data_in(0) xor data_in(1) xor data_in(2) xor data_in(3) xor data_in(4) xor data_in(5) xor data_in(6) xor data_in(7) xor data_in(8) xor data_in(9) xor data_in(10) xor data_in(11) xor data_in(12) xor data_in(13) xor data_in(14) xor data_in(15) xor cb1 xor cb2 xor cb3 xor cb4 xor cb5; 
	data_out<=cb0 & cb1 & cb2 & cb3 & cb4 & cb5 & cb6;
	end process;
end Behavioral;

