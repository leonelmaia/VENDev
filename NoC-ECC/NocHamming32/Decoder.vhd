library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
port(	data_in: IN STD_LOGIC_VECTOR(38 DOWNTO 0);
		data_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)); 
end Decoder;

architecture Behavioral of Decoder is
begin
	process (data_in)
	variable data: STD_LOGIC_VECTOR (31 DOWNTO 0);
	variable SPB: STD_LOGIC_VECTOR (6 DOWNTO 0);
	variable ED: STD_LOGIC;
	
	begin
			data (31 DOWNTO 0):=data_in (31 DOWNTO 0);
			
			SPB(0):=data_in(32)XOR data_in(0)XOR data_in(1)XOR data_in(3)XOR data_in(4)XOR data_in(6)XOR data_in(8)XOR data_in(10)XOR data_in(11)XOR data_in(13)XOR data_in(15)XOR data_in(17)XOR data_in(19)XOR data_in(21)XOR data_in(23)XOR data_in(25)XOR data_in(26)XOR data_in(28)XOR data_in(30);
			SPB(1):=data_in(33)XOR data_in(0)XOR data_in(2)XOR data_in(3)XOR data_in(5)XOR data_in(6)XOR data_in(9)XOR data_in(10)XOR data_in(12)XOR data_in(13)XOR data_in(16)XOR data_in(17)XOR data_in(20)XOR data_in(21)XOR data_in(24)XOR data_in(25)XOR data_in(27)XOR data_in(28)XOR data_in(31);
			SPB(2):=data_in(34)XOR data_in(1)XOR data_in(2)XOR data_in(3)XOR data_in(7)XOR data_in(8)XOR data_in(9)XOR data_in(10)XOR data_in(14)XOR data_in(15)XOR data_in(16)XOR data_in(17)XOR data_in(22)XOR data_in(23)XOR data_in(24)XOR data_in(25)XOR data_in(29)XOR data_in(30)XOR data_in(31);
			SPB(3):=data_in(35)XOR data_in(4)XOR data_in(5)XOR data_in(6)XOR data_in(7)XOR data_in(8)XOR data_in(9)XOR data_in(10)XOR data_in(18)XOR data_in(19)XOR data_in(20)XOR data_in(21)XOR data_in(22)XOR data_in(23)XOR data_in(24)XOR data_in(25);
			SPB(4):=data_in(36)XOR data_in(11)XOR data_in(12)XOR data_in(13)XOR data_in(14)XOR data_in(15)XOR data_in(16)XOR data_in(17)XOR data_in(18)XOR data_in(19)XOR data_in(20)XOR data_in(21)XOR data_in(22)XOR data_in(23)XOR data_in(24)XOR data_in(25);
			SPB(5):=data_in(37)XOR data_in(26)XOR data_in(27)XOR data_in(28)XOR data_in(29)XOR data_in(30)XOR data_in(31);
			SPB(6):=data_in(38)XOR data_in(0)XOR data_in(1)XOR data_in(2)XOR data_in(3)XOR data_in(4)XOR data_in(5)XOR data_in(6)XOR data_in(7)XOR data_in(8)XOR data_in(9)XOR data_in(10)XOR data_in(11)XOR data_in(12)XOR data_in(13)XOR data_in(14)XOR data_in(15)XOR data_in(16)XOR data_in(17)XOR data_in(18)XOR data_in(19)XOR data_in(20)XOR data_in(21)XOR data_in(22)XOR data_in(23)XOR data_in(24)XOR data_in(25)XOR data_in(26)XOR data_in(27)XOR data_in(28)XOR data_in(29)XOR data_in(30)XOR data_in(31)XOR data_in(32)XOR data_in(33)XOR data_in(34)XOR data_in(35)XOR data_in(36)XOR data_in(37);
			
			CASE SPB IS
				WHEN "1000011"=>
				data(0):= NOT data(0);
				WHEN "1000101"=>
				data(1):= NOT data(1);
				WHEN "1000110"=>
				data(2):= NOT data(2);
				WHEN "1000111"=>
				data(3):= NOT data(3);
				WHEN "1001001"=>
				data(4):= NOT data(4);
				WHEN "1001010"=>
				data(5):= NOT data(5);
				WHEN "1001011"=>
				data(6):= NOT data(6);
				WHEN "1001100"=>
				data(7):= NOT data(7);
				WHEN "1001101"=>
				data(8):= NOT data(8);
				WHEN "1001110"=>
				data(9):= NOT data(9);
				WHEN "1001111"=>
				data(10):= NOT data(10);
				WHEN "1010001"=>
				data(11):= NOT data(11);
				WHEN "1010010"=>
				data(12):= NOT data(12);
				WHEN "1010011"=>
				data(13):= NOT data(13);
				WHEN "1010100"=>
				data(14):= NOT data(14);
				WHEN "1010101"=>
				data(15):= NOT data(15);
				WHEN "1010110"=>
				data(16):= NOT data(16);
				WHEN "1010111"=>
				data(17):= NOT data(17);
				WHEN "1011000"=>
				data(18):= NOT data(18);
				WHEN "1011001"=>
				data(19):= NOT data(19);
				WHEN "1011010"=>
				data(20):= NOT data(20);
				WHEN "1011011"=>
				data(21):= NOT data(21);
				WHEN "1011100"=>
				data(22):= NOT data(22);
				WHEN "1011101"=>
				data(23):= NOT data(23);
				WHEN "1011110"=>
				data(24):= NOT data(24);
				WHEN "1011111"=>
				data(25):= NOT data(25);
				WHEN "1100001"=>
				data(26):= NOT data(26);
				WHEN "1100010"=>
				data(27):= NOT data(27);
				WHEN "1100011"=>
				data(28):= NOT data(28);
				WHEN "1100100"=>
				data(29):= NOT data(29);
				WHEN "1100101"=>
				data(30):= NOT data(30);
				WHEN "1100110"=>
				data(31):= NOT data(31);
				WHEN OTHERS=>
				
			END CASE;
			data_out<=data;
	end process;

end Behavioral;

