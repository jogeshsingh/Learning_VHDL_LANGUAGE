--------------------------------------------
-- Design name : Test_configurable_adder
-- HDL         : VHDL
--------------------------------------------


library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

-- entity declaration

entity Test_configurable_adder is 
end entity Test_configurable_adder ;

-- architecture definition

architecture rtl_test of Test_configurable_adder is 

-- constant declaration

constant ADDER_W : natural := 16 ;

-- component declaration 

component configurable_adder is 
generic (
          WIDTH_N : natural := 16
		  ) ;
port (
        in_a  : in  std_logic_vector (WIDTH_N downto 0) ;
		  in_b  : in  std_logic_vector (WIDTH_N downto 0) ;
		  in_c  : in  std_logic                             ;
		  o_cout: out std_logic                             ;
		  o_sum : out std_logic_vector (WIDTH_N downto 0) 
	 ) ;
	 
end component ;


--- signal declaration 

signal i_a   : std_logic_vector (ADDER_W  downto 0) := (others => '0') ;
signal i_b   : std_logic_vector (ADDER_W  downto 0) := (others => '0') ;
signal i_c   : std_logic := '0' ;
signal o_c   : std_logic := '0' ;
signal o_sum : std_logic_vector (ADDER_W  downto 0) := (others => '0') ;


begin



-- design under test

 dut : configurable_adder 
       generic map(
          WIDTH_N => ADDER_W 
		        ) 
       port map (
        in_a   =>  i_a  , 
		  in_b   =>  i_b  , 
		  in_c   =>  i_c  , 
		  o_cout =>  o_c  , 
		  o_sum  =>  o_sum 
	    ) ;
	
	
	
	
	
 -- test vector generation
 
 test_proc : process
 begin
    for i in 0  to 50 loop 
	     wait for 20 ns ;
	        i_c <=  '1' ;
		     i_a <= i_a + 1 ;
		     i_b <= i_b + 2 ;
		   if (i = 50) then 
		 exit ;
		end if ;
	end loop ;
 end process test_proc ;
 
 
 
 

 end architecture  rtl_test ;
 
 
 
 
 