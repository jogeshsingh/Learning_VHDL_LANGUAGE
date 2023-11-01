-------------------------------------------------------------------------------
-- Design name -: updown_count_testbench
-- Designer    -: Jogesh singh
-------------------------------------------------------------------------------


 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.std_logic_arith.all;
 use ieee.std_logic_unsigned.all ;
 
 
 entity updown_count_testbench is 
 end entity updown_count_testbench;
 
 
 architecture updown_rtl of updown_count_testbench is
 
  -- component declaration
  
  component updown_count is 
  generic (
    width  : integer := 32
	);
  port 
    (
	  i_clk    : in  std_logic        ;                                    -- fpga clock
	  i_rst    : in  std_logic        ;                                    -- active low reset
	  i_cnt_en : in  std_logic        ;                                    -- signal for enabling up(1) and down(0) count operation
	  o_cnt    : out std_logic_vector ( width - 1 downto 0)                -- output count operation 
	);  
	
 end component ;
 
 
   -- signal declaration 
   
   signal   i_clk                    : std_logic := '1'                   ;
   signal   i_rst                    : std_logic := '0'                   ;
   signal   i_cnt_en                 : std_logic := '0'                   ;
   signal   counter_out              : std_logic_vector(31 downto 0) ;
   constant CLK_FREQ                 :  integer  := 10e6                  ;  -- 100 MHZ 
   constant CLK_PERIOD               : time      := 1000ms/CLK_FREQ       ;
   
    --100 MHZ = 10 ns 
   -- end signal description
   
   begin
     
	 
	------------------------------------------------------------------------ 
	-- design under test 
	DUT : updown_count
	
	 	generic map (width => 32) -- Adjust the width as needed
	   port map
	            (
				    i_clk    => i_clk , 
					 i_rst    => i_rst , 
					 i_cnt_en => i_cnt_en , 
					 o_cnt    => counter_out 
				   ) ;
	

    -------------------------------------------------------------------------
    -- clock generation
	
	--i_clk  <= not i_clk after clk_period/2                               ; 
	
	
	------------------------------------------------------------------------
	--or the following could be used for generating the clock 
	
    clk_gen_proc : process 
	                begin
				    i_clk <= '0' ;  wait for 10 ns ;
					 i_clk <= '1' ;  wait for 10 ns ; 
       end process clk_gen_proc ;
    ------------------------------------------------------------------------				 
    
	
	reset_gen_proc : process
	 begin
	               i_rst <= '0' ; wait for 20 ns ;
				      i_rst <= '1' ; wait for 2000 ns ;
	   end process reset_gen_proc ;
	 
	------------------------------------------------------------------------- 

    rtl_i_cnt_en_proc : process
	     begin
		          wait for 150 ns ;
				    i_cnt_en <= '1' ; wait for 10 ns ;
				    i_cnt_en <= '0' ; wait for 550 ns ;
		          i_cnt_en <= '1' ; wait for 350 ns ;
				    i_cnt_en <= '0' ; wait for 550 ns ;
				    i_cnt_en <= '1' ; wait for 350 ns ;
	    end process rtl_i_cnt_en_proc ;
	--------------------------------------------------------------------------
		 
		    
		           
   	end architecture updown_rtl ;
				  
  