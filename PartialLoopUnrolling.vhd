----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:20:01 12/22/2014 
-- Design Name: 
-- Module Name:    PartialLoopUnrolling - Behavioral 
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


-- Add elements from a to b
-- a : int[] = {1, 2, 3, 4, 5, 6, 7}
-- b : int[] = {10, 20, 30, 40, 50, 60, 70}
-- c : int[] = {}
-- for (int i = 0; i < 7; ++i) {
--		c[i] = a[i] + b[i]
-- }
--
-- Semantics
--
-- a = allocate_array(7)
-- b = allocate_array(7)
-- c = allocate_array(7)
-- a = {1, 2, 3, 4, 5, 6, 7}
-- b = {10, 20, 30, 40, 50, 60, 70}
-- i = 2
-- n = floor(7/i) = 3
-- last = 7 mod 2 = 1
-- cnt = 7 - 1 = 6
-- for (int i = 0; i < cnt; i += n) 
-- {
--		c[i] = a[i] + b[i]
--		c[i+1] = a[i+1] + b[i+1]	
--		c[i+2] = a[i+2] + b[i+2]
--		cnt = cnt + n
-- }
--
-- for (int i = 0; i < last; i += n)
-- { 
--		c[i] = a[i] + b[i]
--		c[i] = a[i] + b[i]
-- }


entity PartialLoopUnrolling is
	Port( 
			clock : in STD_LOGIC;
			reset : in STD_LOGIC
		 );
end PartialLoopUnrolling;

architecture Behavioral of PartialLoopUnrolling is

	component ALU_Add is
		Port( 
				reset : in STD_LOGIC;
				op1 : in STD_LOGIC_VECTOR (31 downto 0);
				op2 : in STD_LOGIC_VECTOR (31 downto 0);
				result : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component ALU_Add;

	type t_static_array_decl is array (0 to 6) of STD_LOGIC_VECTOR(31 downto 0);

	signal array_a : t_static_array_decl :=
	(
		X"00000001", 	-- 1
		X"00000002", 	-- 2
		X"00000003", 	-- 3
		X"00000004", 	-- 4
		X"00000005", 	-- 5
		X"00000006", 	-- 6
		X"00000007"  	-- 7
	);
	
	signal array_b : t_static_array_decl :=
	(
		X"0000000A",	-- 10 
		X"00000014",	-- 20 
		X"0000001E",	-- 30
		X"00000028", 	-- 40
		X"00000032", 	-- 50
		X"0000003C",	-- 60
		X"00000046"		-- 70
	);
	
	signal array_c : t_static_array_decl :=
	(
		X"00000000", 
		X"00000000", 
		X"00000000", 
		X"00000000", 
		X"00000000", 
		X"00000000", 
		X"00000000" 
	);
	
begin

	Add0 : ALU_Add port map
	(
		reset => reset,
		op1 => array_a(0),
		op2 => array_b(0),
		result => array_c(0)
	);
	
	Add1 : ALU_Add port map
	(
		reset => reset,
		op1 => array_a(1),
		op2 => array_b(1),
		result => array_c(1)
	);
	
	Add2 : ALU_Add port map
	(
		reset => reset,
		op1 => array_a(2),
		op2 => array_b(2),
		result => array_c(2)
	);

end Behavioral;

