library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.NoCPackage.all;

package TablePackage is

constant NREG : integer := 4;
constant MEMORY_SIZE : integer := NREG;
constant NBITS : integer := 4;
constant CELL_SIZE : integer := 2*NPORT+4*NBITS;

subtype cell is std_logic_vector(CELL_SIZE-1 downto 0);
subtype regAddr is std_logic_vector(2*NBITS-1 downto 0);
type memory is array (0 to MEMORY_SIZE-1) of cell;
type tables is array (0 to NROT-1) of memory;
subtype ports is std_logic_vector(NPORT-1 downto 0);

function input_ports(region : cell) return ports;
function output_ports(region : cell) return ports;
function upper_right_x(region : cell) return natural;
function upper_right_y(region : cell) return natural;
function lower_left_x(region : cell) return natural;
function lower_left_y(region : cell) return natural;

constant TAB: tables :=(
 -- Router 0.0
(("10000000000010000101000100"),
("10000000100001010101000001"),
("00000000000000000000000000"),
("00000000000000000000000000")
),
 -- Router 0.1
(("11100000100001010000100001"),
("11001000000101010101000100"),
("10101000000000000000001000"),
("00000000000000000000000000")
),
 -- Router 0.2
(("11000000000110000101000100"),
("10101000000001010000101000"),
("11000000100001010101000001"),
("00000000000000000000000000")
),
 -- Router 0.3
(("10101000000000000001001000"),
("11100000100001010001100001"),
("11001000001001010101000100"),
("00000000000000000000000000")
),
 -- Router 0.4
(("11000000001010000101000100"),
("10101000000001010001101000"),
("11000000100001010101000001"),
("00000000000000000000000000")
),
 -- Router 0.5
(("10101000000000000010001000"),
("11001000001101010101000100"),
("11100000100001010010100001"),
("00000000000000000000000000")
),
 -- Router 0.6
(("11000000001110000101000100"),
("10101000000001010010101000"),
("11000000100001010101000001"),
("00000000000000000000000000")
),
 -- Router 0.7
(("10101000000000000011001000"),
("11001000010001010101000100"),
("11100000100001010011100001"),
("00000000000000000000000000")
),
 -- Router 0.8
(("11000000010010000101000100"),
("10101000000001010011101000"),
("11000000100001010101000001"),
("00000000000000000000000000")
),
 -- Router 0.9
(("11001000010100000101000100"),
("10101000000000000100001000"),
("11100000100001010101000001"),
("00000000000000000000000000")
),
 -- Router 0.10
(("11000000110101010101000001"),
("10001000000001010100101000"),
("00000000000000000000000000"),
("00000000000000000000000000")
),
 -- Router 1.0
(("10101000000000000000000010"),
("10010000000010001101000100"),
("10010001000001010101000001"),
("00000000000000000000000000")
),
 -- Router 1.1
(("10111000000000001000001000"),
("11001000000000000000100010"),
("11110001000001010000100001"),
("11001000000101010101000100")
),
 -- Router 1.2
(("11101000000000000001000010"),
("11010000000110001101000100"),
("10111000100001010000101000"),
("11010001000001010101000001")
),
 -- Router 1.3
(("10111000000000001001001000"),
("11001000000000000101000010"),
("11110001000001010001100001"),
("11001000101001010101000100")
),
 -- Router 1.4
(("11101000000000000010000010"),
("11010000001010001101000100"),
("10111000100001010001101000"),
("11010001000001010101000001")
),
 -- Router 1.5
(("10111000000000001010001000"),
("11001000000000000101000010"),
("11001000101101010101000100"),
("11110001000001010010100001")
),
 -- Router 1.6
(("11101000000000000011000010"),
("11010000001110001101000100"),
("10111000100001010010101000"),
("11010001000001010101000001")
),
 -- Router 1.7
(("11001000000000000101000010"),
("10111000000000001011001000"),
("11001000110001010101000100"),
("11110001000001010011100001")
),
 -- Router 1.8
(("11010000010010001101000100"),
("11101000000000000100000010"),
("10111000100001010011101000"),
("11010001000001010101000001")
),
 -- Router 1.9
(("10111000100000001100001000"),
("11011000110101010101000100"),
("11101000000000000101000010"),
("11110001000001010100100001")
),
 -- Router 1.10
(("10001000000000000101000010"),
("11010001000001010101000001"),
("10001000100001010100101000"),
("00000000000000000000000000")
),
 -- Router 2.0
(("10101000000000001000000010"),
("10010000000010010101000100"),
("10010001100001010101000001"),
("00000000000000000000000000")
),
 -- Router 2.1
(("10111000000000010000001000"),
("11001000000000001000100010"),
("11110001100001010000100001"),
("11001000000101010101000100")
),
 -- Router 2.2
(("11101000000000001001000010"),
("10111001000001010000101000"),
("11010000000110010101000100"),
("11010001100001010101000001")
),
 -- Router 2.3
(("10111000000000010001001000"),
("11001000000000001101000010"),
("11110001100001010001100001"),
("11001001001001010101000100")
),
 -- Router 2.4
(("11101000000000001010000010"),
("11010000001010010101000100"),
("10111001000001010001101000"),
("11010001100001010101000001")
),
 -- Router 2.5
(("10111000000000010010001000"),
("11001000000000001101000010"),
("11001001001101010101000100"),
("11110001100001010010100001")
),
 -- Router 2.6
(("11010000001110010101000100"),
("11101000000000001011000010"),
("10111001000001010010101000"),
("11010001100001010101000001")
),
 -- Router 2.7
(("10111000000000010011001000"),
("11001000000000001101000010"),
("11001001010001010101000100"),
("11110001100001010011100001")
),
 -- Router 2.8
(("11010000010010010101000100"),
("11101000000000001100000010"),
("10111001000001010011101000"),
("11010001100001010101000001")
),
 -- Router 2.9
(("11001001010101010101000100"),
("11001000000000001101000010"),
("10111000000000010100001000"),
("11110001100001010100100001")
),
 -- Router 2.10
(("10011001000000010100101000"),
("11001000000000001101000010"),
("11010001100001010101000001"),
("00000000000000000000000000")
),
 -- Router 3.0
(("10101000000000010000000010"),
("10010000000010011101000100"),
("10010010000001010101000001"),
("00000000000000000000000000")
),
 -- Router 3.1
(("10111000000000011000001000"),
("11001000000000010000100010"),
("11110010000001010000100001"),
("11001000000101010101000100")
),
 -- Router 3.2
(("11101000000000010001000010"),
("10111001100001010000101000"),
("11010000000110011101000100"),
("11010010000001010101000001")
),
 -- Router 3.3
(("10111000000000011001001000"),
("11110010000001010001100001"),
("11001000000000010101000010"),
("11001001101001010101000100")
),
 -- Router 3.4
(("11101000000000010010000010"),
("11010000001010011101000100"),
("10111001100001010001101000"),
("11010010000001010101000001")
),
 -- Router 3.5
(("10111000000000011010001000"),
("11001000000000010101000010"),
("11001001101101010101000100"),
("11110010000001010010100001")
),
 -- Router 3.6
(("11010000001110011101000100"),
("11101000000000010011000010"),
("10111001100001010010101000"),
("11010010000001010101000001")
),
 -- Router 3.7
(("11001001110001010101000100"),
("10111000000000011011001000"),
("11001000000000010101000010"),
("11110010000001010011100001")
),
 -- Router 3.8
(("11010000010010011101000100"),
("11101000000000010100000010"),
("10111001100001010011101000"),
("11010010000001010101000001")
),
 -- Router 3.9
(("11001001110101010101000100"),
("11001000000000010101000010"),
("10111000000000011100001000"),
("11110010000001010100100001")
),
 -- Router 3.10
(("10011001100000011100101000"),
("11001000000000010101000010"),
("11010010000001010101000001"),
("00000000000000000000000000")
),
 -- Router 4.0
(("10101000000000011000000010"),
("10010000000010100101000100"),
("10010010100001010101000001"),
("00000000000000000000000000")
),
 -- Router 4.1
(("10111000000000100000001000"),
("11001000000000011000100010"),
("11110010100001010000100001"),
("11001000000101010101000100")
),
 -- Router 4.2
(("11101000000000011001000010"),
("10111010000001010000101000"),
("11010000000110100101000100"),
("11010010100001010101000001")
),
 -- Router 4.3
(("10111000000000100001001000"),
("11110010100001010001100001"),
("11001000000000011101000010"),
("11001010001001010101000100")
),
 -- Router 4.4
(("11101000000000011010000010"),
("10111010000001010001101000"),
("11010000001010100101000100"),
("11010010100001010101000001")
),
 -- Router 4.5
(("10111000000000100010001000"),
("11001010001101010101000100"),
("11110010100001010010100001"),
("11001000000000011101000010")
),
 -- Router 4.6
(("11010000001110100101000100"),
("11101000000000011011000010"),
("10111010000001010010101000"),
("11010010100001010101000001")
),
 -- Router 4.7
(("11001010010001010101000100"),
("10111000000000100011001000"),
("11001000000000011101000010"),
("11110010100001010011100001")
),
 -- Router 4.8
(("11010000010010100101000100"),
("11101000000000011100000010"),
("10111010000001010011101000"),
("11010010100001010101000001")
),
 -- Router 4.9
(("11001010010101010101000100"),
("11001000000000011101000010"),
("10111000000000100100001000"),
("11110010100001010100100001")
),
 -- Router 4.10
(("10011010000000100100101000"),
("11001000000000011101000010"),
("11010010100001010101000001"),
("00000000000000000000000000")
),
 -- Router 5.0
(("10101000000000100000000010"),
("10010011000001010101000001"),
("10010000000010101101000100"),
("00000000000000000000000000")
),
 -- Router 5.1
(("10111000000000101000001000"),
("11110011000001010000100001"),
("11001000000000100000100010"),
("11001000000101010101000100")
),
 -- Router 5.2
(("10111010100001010000101000"),
("11101000000000100001000010"),
("11010000000110101101000100"),
("11010011000001010101000001")
),
 -- Router 5.3
(("10111000000000101001001000"),
("11110011000001010001100001"),
("11001010101001010101000100"),
("11001000000000100101000010")
),
 -- Router 5.4
(("10111010100001010001101000"),
("11101000000000100010000010"),
("11010000001010101101000100"),
("11010011000001010101000001")
),
 -- Router 5.5
(("11001010101101010101000100"),
("10111000000000101010001000"),
("11110011000001010010100001"),
("11001000000000100101000010")
),
 -- Router 5.6
(("11010000001110101101000100"),
("11101000000000100011000010"),
("10111010100001010010101000"),
("11010011000001010101000001")
),
 -- Router 5.7
(("11001010110001010101000100"),
("11110011000001010011100001"),
("10111000000000101011001000"),
("11001000000000100101000010")
),
 -- Router 5.8
(("11010000010010101101000100"),
("11101000000000100100000010"),
("10111010100001010011101000"),
("11010011000001010101000001")
),
 -- Router 5.9
(("11001010110101010101000100"),
("11110011000001010100100001"),
("10111000000000101100001000"),
("11001000000000100101000010")
),
 -- Router 5.10
(("10011010100000101100101000"),
("11010011000001010101000001"),
("11001000000000100101000010"),
("00000000000000000000000000")
),
 -- Router 6.0
(("10101000000000101000000010"),
("10010011100001010101000001"),
("10010000000010110101000100"),
("00000000000000000000000000")
),
 -- Router 6.1
(("10111000000000110000001000"),
("11110011100001010000100001"),
("11001000000000101000100010"),
("11001000000101010101000100")
),
 -- Router 6.2
(("10111011000001010000101000"),
("11101000000000101001000010"),
("11010011100001010101000001"),
("11010000000110110101000100")
),
 -- Router 6.3
(("11110011100001010001100001"),
("10111000000000110001001000"),
("11001011001001010101000100"),
("11001000000000101101000010")
),
 -- Router 6.4
(("10111011000001010001101000"),
("11101000000000101010000010"),
("11010000001010110101000100"),
("11010011100001010101000001")
),
 -- Router 6.5
(("11110011100001010010100001"),
("11001011001101010101000100"),
("10111000000000110010001000"),
("11001000000000101101000010")
),
 -- Router 6.6
(("11010000001110110101000100"),
("10111011000001010010101000"),
("11101000000000101011000010"),
("11010011100001010101000001")
),
 -- Router 6.7
(("11001011010001010101000100"),
("11110011100001010011100001"),
("10111000000000110011001000"),
("11001000000000101101000010")
),
 -- Router 6.8
(("11010000010010110101000100"),
("10111011000001010011101000"),
("11010011100001010101000001"),
("11101000000000101100000010")
),
 -- Router 6.9
(("11001000010101010101000100"),
("11110011100001010100100001"),
("11001000000000101100100010"),
("10111000000000110100001000")
),
 -- Router 6.10
(("10011011000000110100101000"),
("11010011100001010101000001"),
("11001000000000101101000010"),
("00000000000000000000000000")
),
 -- Router 7.0
(("10101000000000110000000010"),
("10010100000001010101000001"),
("10010000000010111101000100"),
("00000000000000000000000000")
),
 -- Router 7.1
(("11110100000001010000100001"),
("10111000000000111000001000"),
("11001000000000110000100010"),
("11001000000101010101000100")
),
 -- Router 7.2
(("10111011100001010000101000"),
("11101000000000110001000010"),
("11010100000001010101000001"),
("11010000000110111101000100")
),
 -- Router 7.3
(("11110100000001010001100001"),
("10111000000000111001001000"),
("11001000000000110001100010"),
("11001000001001010101000100")
),
 -- Router 7.4
(("10111011100001010001101000"),
("11010100000001010101000001"),
("11101000000000110010000010"),
("11010000001010111101000100")
),
 -- Router 7.5
(("11110100000001010010100001"),
("11001011101101010101000100"),
("10111000000000111010001000"),
("11001000000000110101000010")
),
 -- Router 7.6
(("10111011100001010010101000"),
("11010000001110111101000100"),
("11010100000001010101000001"),
("11101000000000110011000010")
),
 -- Router 7.7
(("11001011110001010101000100"),
("11110100000001010011100001"),
("10111000000000111011001000"),
("11001000000000110101000010")
),
 -- Router 7.8
(("11010000010010111101000100"),
("10111011100001010011101000"),
("11010100000001010101000001"),
("11101000000000110100000010")
),
 -- Router 7.9
(("11001000010101010101000100"),
("11110100000001010100100001"),
("11001000000000110100100010"),
("10111000000000111100001000")
),
 -- Router 7.10
(("10011011100000111100101000"),
("11010100000001010101000001"),
("11001000000000110101000010"),
("00000000000000000000000000")
),
 -- Router 8.0
(("10101000000000111000000010"),
("10010100100001010101000001"),
("10010000000011000101000100"),
("00000000000000000000000000")
),
 -- Router 8.1
(("11110100100001010000100001"),
("10111000000001000000001000"),
("11001000000000111000100010"),
("11001000000101010101000100")
),
 -- Router 8.2
(("10111100000001010000101000"),
("11010100100001010101000001"),
("11101000000000111001000010"),
("11010000000111000101000100")
),
 -- Router 8.3
(("11110100100001010001100001"),
("10111000000001000001001000"),
("11001000000000111001100010"),
("11001000001001010101000100")
),
 -- Router 8.4
(("10111100000001010001101000"),
("11010100100001010101000001"),
("11101000000000111010000010"),
("11010000001011000101000100")
),
 -- Router 8.5
(("11110100100001010010100001"),
("11001100001101010101000100"),
("10111000000001000010001000"),
("11001000000000111101000010")
),
 -- Router 8.6
(("10111100000001010010101000"),
("11010100100001010101000001"),
("11010000001111000101000100"),
("11101000000000111011000010")
),
 -- Router 8.7
(("11001100010001010101000100"),
("11110100100001010011100001"),
("10111000000001000011001000"),
("11001000000000111101000010")
),
 -- Router 8.8
(("11010000010011000101000100"),
("11010100100001010101000001"),
("10111100000001010011101000"),
("11101000000000111100000010")
),
 -- Router 8.9
(("11001000010101010101000100"),
("11110100100001010100100001"),
("11001000000000111100100010"),
("10111000000001000100001000")
),
 -- Router 8.10
(("10011100000001000100101000"),
("11010100100001010101000001"),
("11001000000000111101000010"),
("00000000000000000000000000")
),
 -- Router 9.0
(("10101000000001000000000010"),
("10010101000001010101000001"),
("10010000000011001101000100"),
("00000000000000000000000000")
),
 -- Router 9.1
(("11110101000001010000100001"),
("10111000000001001000001000"),
("11001000000001000000100010"),
("11001000000101010101000100")
),
 -- Router 9.2
(("10111100100001010000101000"),
("11010101000001010101000001"),
("11101000000001000001000010"),
("11010000000111001101000100")
),
 -- Router 9.3
(("11110101000001010001100001"),
("10111000000001001001001000"),
("11001000000001000001100010"),
("11001000001001010101000100")
),
 -- Router 9.4
(("10111100100001010001101000"),
("11010101000001010101000001"),
("11101000000001000010000010"),
("11010000001011001101000100")
),
 -- Router 9.5
(("11110101000001010010100001"),
("11001100101101010101000100"),
("10111000000001001010001000"),
("11001000000001000101000010")
),
 -- Router 9.6
(("11010101000001010101000001"),
("10111100100001010010101000"),
("11010000001111001101000100"),
("11101000000001000011000010")
),
 -- Router 9.7
(("11110101000001010011100001"),
("11001000010001010101000100"),
("10111000000001001011001000"),
("11001000000001000011100010")
),
 -- Router 9.8
(("11010101000001010101000001"),
("10111100100001010011101000"),
("11010000010011001101000100"),
("11101000000001000100000010")
),
 -- Router 9.9
(("11110101000001010100100001"),
("11001000010101010101000100"),
("10111000000001001100001000"),
("11001000000001000100100010")
),
 -- Router 9.10
(("10011100100001001100101000"),
("11010101000001010101000001"),
("11001000000001000101000010"),
("00000000000000000000000000")
),
 -- Router 10.0
(("10010000000011010101000100"),
("10100000000001001000000010"),
("00000000000000000000000000"),
("00000000000000000000000000")
),
 -- Router 10.1
(("10110000000001010000001000"),
("11000000000001001000100010"),
("11000000000101010101000100"),
("00000000000000000000000000")
),
 -- Router 10.2
(("10110101000001010000101000"),
("11100000000001001001000010"),
("11010000000111010101000100"),
("00000000000000000000000000")
),
 -- Router 10.3
(("10110000000001010001001000"),
("11000000000001001001100010"),
("11000000001001010101000100"),
("00000000000000000000000000")
),
 -- Router 10.4
(("10110101000001010001101000"),
("11100000000001001010000010"),
("11010000001011010101000100"),
("00000000000000000000000000")
),
 -- Router 10.5
(("10110000000001010010001000"),
("11000000001101010101000100"),
("11000000000001001010100010"),
("00000000000000000000000000")
),
 -- Router 10.6
(("10110101000001010010101000"),
("11010000001111010101000100"),
("11100000000001001011000010"),
("00000000000000000000000000")
),
 -- Router 10.7
(("11000000010001010101000100"),
("10110000000001010011001000"),
("11000000000001001011100010"),
("00000000000000000000000000")
),
 -- Router 10.8
(("10110101000001010011101000"),
("11010000010011010101000100"),
("11100000000001001100000010"),
("00000000000000000000000000")
),
 -- Router 10.9
(("11000000010101010101000100"),
("10110000000001010100001000"),
("11000000000001001100100010"),
("00000000000000000000000000")
),
 -- Router 10.10
(("10010101000001010100101000"),
("11000000000001001101000010"),
("00000000000000000000000000"),
("00000000000000000000000000")
)
);
end TablePackage;

package body TablePackage is

function input_ports(region : cell) return ports is
    variable result : std_logic_vector(NPORT-1 downto 0);
begin
    result := region(CELL_SIZE-1 downto CELL_SIZE-5);
    return result;
end input_ports;

function output_ports(region : cell) return ports is
begin
    return region(NPORT-1 downto 0);
end output_ports;

function upper_right_x(region : cell) return natural is
begin
    return TO_INTEGER(unsigned(region(CELL_SIZE-6-2*NBITS downto CELL_SIZE-5-3*NBITS)));
end upper_right_x;

function upper_right_y(region : cell) return natural is
begin
    return TO_INTEGER(unsigned(region(CELL_SIZE-6-3*NBITS downto 5)));
end upper_right_y;

function lower_left_x(region : cell) return natural is
begin
    return TO_INTEGER(unsigned(region(CELL_SIZE-6 downto CELL_SIZE-5-NBITS)));
end lower_left_x;

function lower_left_y(region : cell) return natural is
begin
    return TO_INTEGER(unsigned(region(CELL_SIZE-6-NBITS downto CELL_SIZE-5-2*NBITS)));
end lower_left_y;

end TablePackage;
