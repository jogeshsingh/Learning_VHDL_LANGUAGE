---------------------------------------
---- Design name : TWO_S_COMPLEMENT
---- HDL         : VHDL 
--------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL ;

entity TWO_S_COMPLEMENT is 
 generic 
         (
		   WIDTH_N : natural := 15
		  ) ;
 port 
          (
		   i_input : in std_logic_vector ((WIDTH_N-1) downto 0);
		   o_output : out std_logic_vector ((WIDTH_N-1) downto 0)
		   ) ;
end entity TWO_S_COMPLEMENT ;


-- architecture definition


architecture rtl_two_s_complement of TWO_S_COMPLEMENT is 

begin
   
     rtl_proc : process(i_input)
     variable i_inverter : unsigned ((WIDTH_N-1) downto 0) ;
  
     begin
           
		     i_inverter := unsigned (not i_input) ;
			 i_inverter := i_inverter + 1 ;
			 o_output   <= std_logic_vector(i_inverter) ;
	end process rtl_proc ;
	
end architecture rtl_two_s_complement ;
			 