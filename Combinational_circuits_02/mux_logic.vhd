-----------------------------------------------------
------------------------------------------------------
-----------------------------------------------------
--------multiplexer 4 to 1  -------------


library ieee ;
use ieee.std_logic_1164.all ;

                                                 ---entity declaration

entity mux_logic is 
 port 
     (
       in_1   : in std_logic_vector (3 downto 0) ;
       sel_in : in std_logic_vector (1 downto 0) ;
       out_m    : out std_logic 
     ) ;

  end entity mux_logic  ;   

                                                 ----architecture definition 

  architecture behav_mux of mux_logic is         ----- data flow modelling 
    
  begin
       out_m <= in_1(0) when (sel_in = "00") else
              in_1(1) when (sel_in = "01") else
              in_1(2) when (sel_in = "10") else
              in_1(3) ;
end behav_mux ;                                -----end architecture