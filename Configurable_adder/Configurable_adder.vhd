--------------------------------------------------
--- Design name -: Configurable adder 
--- HDL         -: VHDL
--------------------------------------------------
library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

-- entity declaration
entity configurable_adder is 
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
	 
end entity configurable_adder ;

-- architecture definition
architecture adder_rtl of configurable_adder is 

begin

  rtl_proc : process (all)
  -- variable declaration   
  variable carry_out  : std_logic := '0' ;
  variable sum       : std_logic_vector (WIDTH_N downto 0) := (others => '0');
  
   begin
         carry_out  := in_c ;
		 for i in 0 to WIDTH_N loop
		 sum(i)     := in_a(i) xor in_b(i) xor carry_out ;
		 carry_out  := (in_a(i) and in_b(i)) or (in_a(i) and carry_out) or (in_b(i) and carry_out) ; 
         end loop ;
	     o_sum  <= sum ;
  	     o_cout <= carry_out ;
   end process rtl_proc ;

 
end architecture adder_rtl ;
 
 