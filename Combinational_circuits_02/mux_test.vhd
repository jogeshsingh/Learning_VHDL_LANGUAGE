---------testbench for mux_logic ----------------

library IEEE ;
use ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;

entity mux_test  is
end entity  ;


architecture mux_rtl of mux_test is
 component mux_logic is 
 port (
    in_1   : in std_logic_vector (3 downto 0) ;
    sel_in : in std_logic_vector (1 downto 0) ;
    out_m    : out std_logic 
 ) ;

 end component  ;

 signal i_1     : std_logic_vector(3 downto 0) ;
 signal i_sel   : std_logic_vector (1 downto 0);
 signal out_mux : std_logic ;
 
 
 begin
     DUT :  mux_logic  port map
        (
       in_1     =>  i_1   ,
       sel_in   =>  i_sel  , 
       out_m    => out_mux   
     ) ;
     
     stimulus : process
     begin
     
     i_1(0) <= '0' ;
     i_1(1) <= '1' ;
     i_1(2) <= '0' ;
     i_1(3) <= '1' ;
     
     i_sel <= "00" ; wait for 10 ns ;
     i_sel <= "01" ;wait for 10 ns ;
     i_sel <= "10" ;wait for 10 ns ;
     i_sel <= "11" ;wait for 10 ns ;
     end process ;
   end mux_rtl ;                      --end_architecture  
     

