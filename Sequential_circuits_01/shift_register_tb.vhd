----------------------------------------------------------------------------------
  -- Design name - : shift_reg_tb 
  -- Designer    - : Jogesh singh
----------------------------------------------------------------------------------


  library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.std_logic_unsigned.all;
  
  
  entity shift_register_tb is
  end entity shift_register_tb ;
  
  
  architecture behav_tb of shift_register_tb is 
  
  
  -- component declaration
  
    component shift_register is 
     port 
       (
	     i_clk        : in  std_logic  ;
		 i_rst        : in  std_logic  ;
		 i_din        : in  std_logic  ;
		 i_shift_en   : in  std_logic  ;
	     o_shift_left : out std_logic  ; 
         o_shift_right: out std_logic  
		);
	
	end component ;
	
	
	--- signal declaration 
	
	 signal i_clk   : std_logic := '0' ;
	 signal i_rst   : std_logic := '0' ;
	 signal i_din   : std_logic := '1' ;
	 signal i_shift : std_logic := '0' ;
	 signal shift_l : std_logic ;
	 signal shift_r : std_logic ;
	
	
	
	begin
	
	   -------------------------------------------------------
	   -- design under test
	   
	   
	    DUT : shift_register 
			  port map (
			            i_clk         => i_clk  , 
						i_rst         => i_rst  , 
						i_din         => i_din  , 
						i_shift_en    => i_shift, 
                        o_shift_left  => shift_l , 
                        o_shift_right => shift_r 						 
			            ) ;
						
						
			
        ------------------------------------------------------

      -- test pattern


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
		 
    ---  test signal proc
	  
	  test_signal_proc : process 
	     begin
		         wait for 50 ns ;
				 
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  
				  wait for 10 ns ;
				  i_shift  <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  i_din <= '0' ; wait for 10 ns ;
				  i_din <= '1' ; wait for 10 ns ;
				  
		          i_din <= '0' ; wait for 100 ns ;
		
		end process test_signal_proc ;

    end architecture behav_tb ; 
						
	  
	  