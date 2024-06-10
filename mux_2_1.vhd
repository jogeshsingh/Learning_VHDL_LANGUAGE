-----------------------------------------------------
------------------------------------------------------
-----------------------------------------------------
--------multiplexer 4 to 1  -------------


library ieee ;
use ieee.std_logic_1164.all ;

                                                 ---entity declaration

entity mux_2_1 is 
 port 
     (
       in_1   : in std_logic   ;
       in_2   : in std_logic   ;
       sel_in : in std_logic  ;
       out_m    : out std_logic 
     ) ;

  end entity mux_2_1   ;   

                                                 ----architecture definition 

  architecture behav_mux of mux_2_1  is         ----- data flow modelling 
    
  begin
       out_m <= in_1  when (sel_in = '0') else
              in_2 ;
end behav_mux ;                                -----end architecture