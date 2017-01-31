library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.ThorPackage.all;
use work.TablePackage.all;
use std.textio.all;

entity test is
end test;

architecture NOC of test is

begin
	FileRead: PROCESS
	file codingInput : TEXT open READ_MODE is "input.txt";
	file telaprint : TEXT open WRITE_MODE is "output.txt";
	variable FileLine : line;
	variable outLine : line;
	variable LineContent : character;
	BEGIN
	WHILE NOT endfile(codingInput) LOOP
	readline(codingInput,FileLine);
	FOR i IN 0 TO FileLine'RIGHT LOOP
	read(FileLine, LineContent);
	if(LineContent = ';') THEN
	ELSIF(LineContent = ' ') THEN
	ELSE
	WRITE(outLine , LineContent);
	END IF;
	END LOOP;
	WAIT FOR 1 ns; 
	writeline(telaprint,outLine);
	WAIT FOR 1 ns;
	END LOOP;
	WAIT FOR 1 ns;
	END PROCESS FileRead;

end NOC;