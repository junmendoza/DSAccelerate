----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:12 12/09/2014 
-- Design Name: 
-- Module Name:    ProgramArgs - Behavioral 
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

------------------------
-- a = x
-- b = y
-- c = a + b
--
-- allocate(x)
-- allocate(y)
-- allocate(a)
-- allocate(b)
-- allocate(c)
-- x = x_in
-- y = y_in
-- a = x
-- b = y
-- c = a + b
------------------------
entity ProgramArgs is
	Port( 
			clock 	: in STD_LOGIC;
			reset 	: in STD_LOGIC;
			x_in 		: in STD_LOGIC_VECTOR (31 downto 0);
			y_in 		: in STD_LOGIC_VECTOR (31 downto 0);
			a_out 	: out STD_LOGIC_VECTOR (31 downto 0);
			b_out 	: out STD_LOGIC_VECTOR (31 downto 0);
			c_out 	: out STD_LOGIC_VECTOR (31 downto 0);
			LCD_E 	: out STD_LOGIC;
			LCD_RS 	: out STD_LOGIC;
			LCD_RW	: out STD_LOGIC;
			LCD_DB	: out STD_LOGIC_VECTOR(7 downto 0);
			LED 		: out STD_LOGIC_VECTOR(7 downto 0)
		  );
end ProgramArgs;

architecture Behavioral of ProgramArgs is
	
	component EmitLCD is
		Port( 
				clock 		: in STD_LOGIC;
				reset 		: in STD_LOGIC; 
				var_index 	: in STD_LOGIC_VECTOR(2 downto 0);		
				LCDDataBus	: out STD_LOGIC_VECTOR(7 downto 0); 
				LCD_E			: out STD_LOGIC;
				LCD_RS		: out STD_LOGIC;
				LCD_RW		: out STD_LOGIC
			 );
	end component EmitLCD;

	component ALU_Add is
		Port( 
				reset : in STD_LOGIC;
				op1 : in STD_LOGIC_VECTOR (31 downto 0);
				op2 : in STD_LOGIC_VECTOR (31 downto 0);
				result : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component ALU_Add;

	signal x : STD_LOGIC_VECTOR (31 downto 0);
	signal y : STD_LOGIC_VECTOR (31 downto 0);
	signal a : STD_LOGIC_VECTOR (31 downto 0);
	signal b : STD_LOGIC_VECTOR (31 downto 0);
	signal c : STD_LOGIC_VECTOR (31 downto 0);

	-- LCD view
	-- index into which variable to preview
	signal var_index: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
	
begin

	EmitMsg : EmitLCD port map
	(
		clock 		=> clock, 
		reset 		=> reset, 	
		var_index 	=> var_index,	
		LCDDataBus 	=> LCD_DB, 
		LCD_E  		=> LCD_E,   
		LCD_RS 		=> LCD_RS,  
		LCD_RW 		=> LCD_RW
	);

	Add0 : ALU_Add port map
	(
		reset => reset,
		op1 => a,
		op2 => b,
		result => c
	);

	ProcExecuteFromArgs : process(x_in, y_in)
	begin
		ResetSync : if reset = '0' then
			x <= x_in;
			y <= y_in;
		end if ResetSync;
	end process ProcExecuteFromArgs;
	
	addop : process(x, y)
	begin
		ResetSync : if reset = '0' then
			a <= x;
			b <= y;
		end if ResetSync;
	end process addop;
	
	assign_a : process(a)
	begin
		ResetSync : if reset = '0' then
			a_out <= a;
		end if ResetSync;
	end process assign_a;
	
	assign_b : process(b)
	begin
		ResetSync : if reset = '0' then
			b_out <= b;
		end if ResetSync;
	end process assign_b;
	
	assign_c : process(c)
	begin
		ResetSync : if reset = '0' then
			c_out <= c;
		end if ResetSync;
	end process assign_c;

end Behavioral;

