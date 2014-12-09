--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:47:57 12/09/2014
-- Design Name:   
-- Module Name:   D:/jun/Research/git/DSAccelerate/Testbench/Testbench_ProgramArgs.vhd
-- Project Name:  SynthesizedProgram
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ProgramArgs
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Testbench_ProgramArgs IS
END Testbench_ProgramArgs;
 
ARCHITECTURE behavior OF Testbench_ProgramArgs IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramArgs
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         x_in : IN  std_logic_vector(31 downto 0);
         y_in : IN  std_logic_vector(31 downto 0);
         a_out : OUT  std_logic_vector(31 downto 0);
         b_out : OUT  std_logic_vector(31 downto 0);
         c_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '1';
   signal x_in : std_logic_vector(31 downto 0) := (others => '0');
   signal y_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal a_out : std_logic_vector(31 downto 0);
   signal b_out : std_logic_vector(31 downto 0);
   signal c_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
	constant clkCycles : integer := 10;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramArgs PORT MAP (
          clock => clock,
          reset => reset,
          x_in => x_in,
          y_in => y_in,
          a_out => a_out,
          b_out => b_out,
          c_out => c_out
        );


	-- Stimulus process
   stim_proc: process
   begin		
		
		clock <= '0';
		reset <= '1';
		wait for 5 ns;
		
		clock <= not clock;
		reset <= '0';
		wait for 1 ns;
		
		clock <= not clock;
		x_in <= X"0000000A";
		y_in <= X"00000005";
		wait for 1 ns;
		
		for i in 1 to clkCycles loop
			clock <= not clock;
			wait for 5 ns;
		end loop;
		
      wait;
		
   end process; 

END;
