library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Encoder is
port( data_in: IN STD_LOGIC_VECTOR (31 downto 0);
		data_out: OUT STD_LOGIC_VECTOR (38 DOWNTO 0));

end Encoder;

architecture Behavioral of Encoder is

begin
	process(data_in)
	variable data:STD_LOGIC_VECTOR (31 DOWNTO 0);
	variable parity:STD_LOGIC_VECTOR (6 DOWNTO 0);
	begin
			data:=data_in;
			parity(0):=data(0)XOR data(1)XOR data(3)XOR data(4)XOR data(6)XOR data(8)XOR data(10)XOR data(11)XOR data(13)XOR data(15)XOR data(17)XOR data(19)XOR data(21)XOR data(23)XOR data(25)XOR data(26)XOR data(28)XOR data(30);
			parity(1):=data(0)XOR data(2)XOR data(3)XOR data(5)XOR data(6)XOR data(9)XOR data(10)XOR data(12)XOR data(13)XOR data(16)XOR data(17)XOR data(20)XOR data(21)XOR data(24)XOR data(25)XOR data(27)XOR data(28)XOR data(31);
			parity(2):=data(1)XOR data(2)XOR data(3)XOR data(7)XOR data(8)XOR data(9)XOR data(10)XOR data(14)XOR data(15)XOR data(16)XOR data(17)XOR data(22)XOR data(23)XOR data(24)XOR data(25)XOR data(29)XOR data(30)XOR data(31);
			parity(3):=data(4)XOR data(5)XOR data(6)XOR data(7)XOR data(8)XOR data(9)XOR data(10)XOR data(18)XOR data(19)XOR data(20)XOR data(21)XOR data(22)XOR data(23)XOR data(24)XOR data(25);
			parity(4):=data(11)XOR data(12)XOR data(13)XOR data(14)XOR data(15)XOR data(16)XOR data(17)XOR data(18)XOR data(19)XOR data(20)XOR data(21)XOR data(22)XOR data(23)XOR data(24)XOR data(25);
			parity(5):=data(26)XOR data(27)XOR data(28)XOR data(29)XOR data(30)XOR data(31);
			parity(6):=data(0)XOR data(1)XOR data(2)XOR data(3)XOR data(4)XOR data(5)XOR data(6)XOR data(7)XOR data(8)XOR data(9)XOR data(10)XOR data(11)XOR data(12)XOR data(13)XOR data(14)XOR data(15)XOR data(16)XOR data(17)XOR data(18)XOR data(19)XOR data(20)XOR data(21)XOR data(22)XOR data(23)XOR data(24)XOR data(25)XOR data(26)XOR data(27)XOR data(28)XOR data(29)XOR data(30)XOR data(31)XOR parity(0)XOR parity(1)XOR parity(2)XOR parity(3)XOR parity(4)XOR parity(5);
		
			data_out<=parity&data;
	end process;
end Behavioral;

