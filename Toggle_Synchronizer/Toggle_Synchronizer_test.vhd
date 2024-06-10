------------------------------------------------------------------------------
--- DESIGN_TESTBENCH : Toggle_Synchronizer_test
------------------------------------------------------------------------------


library IEEE                             ;
use IEEE.std_logic_1164.all              ;
use IEEE.std_logic_unsigned.all          ;


------------------------------------------
-- entity declaration
------------------------------------------

entity Toggle_Synchronizer_test is 
end entity Toggle_Synchronizer_test              ;


------------------------------------------
-- architecture definition
------------------------------------------

architecture rtl_test of Toggle_Synchronizer_test is 

-----------------------------------------
-- component declaration
-----------------------------------------

component Toggle_Synchronizer is 
port 
       (
	     i_clk_src  : in  std_logic           ;
		 i_clk_dest : in  std_logic           ;
		 i_rst      : in  std_logic           ;
		 i_din      : in  std_logic           ;
		 o_pulse    : out std_logic           
	   )                                      ;
end component Toggle_Synchronizer             ;



----------------------------------------
-- Signal declaration
----------------------------------------

signal i_clk_src  :   std_logic  := '0'  ;
signal i_clk_dest :   std_logic  := '0'  ;
signal i_rst      :   std_logic  := '1'  ;
signal i_din      :   std_logic  := '0'  ;
signal o_pulse    :   std_logic  := '0'  ;
 



begin

-----------------------------------------
-- DUT
-----------------------------------------



 DUT_PROC : Toggle_Synchronizer
  port map   
            (
                i_clk_src   => i_clk_src  , 			
                i_clk_dest  => i_clk_dest ,    			
                i_rst       => i_rst      , 
                i_din       => i_din      , 
                o_pulse     => o_pulse    
		    );		


 ------------------------				
 -- clock process 
 ------------------------
 clk_proc_a : process 
 begin
    wait for 5 ns ;
	i_clk_src <= '0'  ;
	wait for 5 ns ;
	i_clk_src <= '1'  ; 
 end process clk_proc_a ;
 
 
 clk_proc_b : process 
 begin
    wait for 20 ns ;
	i_clk_dest <= '0'  ;
	wait for 20 ns ;
	i_clk_dest <= '1'  ; 
 end process clk_proc_b ;

 ------------------------
 -- reset processs
 ------------------------
 rst_proc : process
 begin
   wait for 20 ns ;
  wait until (rising_edge(i_clk_src)) ;
 i_rst  <= '0' ;
 --i_pStrbe <= "1111" ;
 end process rst_proc ;
  
 -----------------------
 --- Pulse generate
 ----------------------- 

 pulse_gen : process 
   begin 
        wait for 200 ns ;
		i_din <= '1'    ;
		wait for 10 ns  ;
		i_din <= '0'    ;
		wait for 200 ns ;
		i_din <= '1'    ;
      wait for 10 ns  ;	
      i_din <= '0'    ;	
	wait            ;
 end process pulse_gen  ;
		
		


 end architecture rtl_test ;