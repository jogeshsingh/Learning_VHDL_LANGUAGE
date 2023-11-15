 ----------------------------------------------------------------------
 
  -- Design -: posedge_tb
  
  ----------------------------------------------------------------------

  
  library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.std_logic_unsigned.all;
  
  
  entity posedge_detector_tb is
  end entity posedge_detector_tb ;
  
  
  architecture behav_tb of posedge_detector_tb is 
   
   -- component declaration
   
    component posedge_detector is
	     port (
		       i_clk   :  in std_logic ;
			   i_rst_n :  in std_logic  ;
			   i_din         : in  std_logic ;
               o_edge_detect : out std_logic       
			   ) ;
	
	end component posedge_detector ;
	
	
	-- signal declaration 
	
	signal  i_clk , i_rst, i_din    : std_logic := '0' ;
	signal  o_edge_detect           : std_logic := '0' ;

    
	
	begin
	  
	-- design under test declaration
	
	 UUT : posedge_detector port map
	                    (
								i_clk         =>  i_clk         , 
								i_rst_n       =>  i_rst         ,  
								i_din         =>  i_din         , 
								o_edge_detect =>  o_edge_detect  
								) ;
				

     -- clock gen process
	    
		rtl_clock_proc : process
		  begin
		           i_clk <= '0'  ; wait for 5 ns ;
				   i_clk <= '1'  ; wait for 5 ns ;
		 end process rtl_clock_proc ;
	
	 -- reset gen process
	 
	     rtl_rst_proc  : process 
		  begin
		            i_rst <= '0' ; wait for  25 ns ;
					i_rst <= '1' ; wait for  100 ns ;
	     end process rtl_rst_proc  ;
		 
		 
	 test_din_proc : process
          begin
                  wait until (i_clk'event and i_clk = '1') ;
                  wait until (i_rst = '1') ;
				  wait for 10 ns ;
				  i_din <= '1' ;
				  wait for 70 ns ;
				  i_din <= '0' ;
          end process test_din_proc ;
		
		
		
  end architecture behav_tb ;