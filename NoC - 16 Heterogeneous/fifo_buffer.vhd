library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.NoCPackage.all;

entity fifo_buffer is
    generic(
        BUFFER_DEPTH : positive;
        BUFFER_WIDTH : positive
    );
    port(
        reset :     in std_logic;
        clock :     in std_logic;
        head:       out std_logic_vector(BUFFER_WIDTH-1 downto 0);
        tail :      in std_logic_vector(BUFFER_WIDTH-1 downto 0);
        push :      in std_logic;
        pull :      in std_logic;
        counter :   out natural
    );
end;


architecture hamming_buffer of fifo_buffer is

signal dataEnc : hammingregflit;
signal dataEncAfterBuff: hammingregflit; 

begin

HammingE: entity work.Encoder(hamming)
		generic map (leng => 21)
		port map(
		data_in => tail,
		data_out => dataEnc
			);	

circularFifoBuffer : entity work.fifo_buffer_real
    generic map(BUFFER_DEPTH => TAM_BUFFER ,
                BUFFER_WIDTH => TAM_FLIT + 6)
    port map(
        reset =>     reset,
        clock =>     clock,
        tail =>      dataEnc,
        push =>      push,
        pull =>      pull,
        counter =>   counter,
        head =>      dataEncAfterBuff
    );

HammingD: entity work.Decoder(hamming)
		generic map (leng => 21)
		port map (
		data_in => dataEncAfterBuff,
		data_out => head
			);
end hamming_buffer;






architecture matrix_buffer of fifo_buffer is

signal dataEnc : matrixregflit;
signal dataEncAfterBuff: matrixregflit; 

begin

matrixE: entity work.Encoder(Matrix)
		generic map (leng => 31)
		port map(
		data_in => tail,
		data_out => dataEnc
			);	

circularFifoBuffer : entity work.fifo_buffer_real
    generic map(BUFFER_DEPTH => TAM_BUFFER ,
                BUFFER_WIDTH => TAM_FLIT + 16)  -- its needed to correct according the ECC
    port map(
        reset =>     reset,
        clock =>     clock,
        tail =>      dataEnc,
        push =>      push,
        pull =>      pull,
        counter =>   counter,
        head =>      dataEncAfterBuff
    );

matrixD: entity work.Decoder(Matrix)
		generic map (leng => 31)
		port map (
		data_in => dataEncAfterBuff,
		data_out => head
			);
end matrix_buffer;


architecture clc_buffer of fifo_buffer is

signal dataEnc : clcregflit;
signal dataEncAfterBuff: clcregflit; 

begin

clcE: entity work.Encoder(clc)
		generic map (leng => 39)
		port map(
		data_in => tail,
		data_out => dataEnc
			);	

circularFifoBuffer : entity work.fifo_buffer_real
    generic map(BUFFER_DEPTH => TAM_BUFFER ,
                BUFFER_WIDTH => TAM_FLIT + 24)  -- its needed to correct according the ECC
    port map(
        reset =>     reset,
        clock =>     clock,
        tail =>      dataEnc,
        push =>      push,
        pull =>      pull,
        counter =>   counter,
        head =>      dataEncAfterBuff
    );

matrixD: entity work.Decoder(clc)
		generic map (leng => 39)
		port map (
		data_in => dataEncAfterBuff,
		data_out => head
			);
end clc_buffer;
