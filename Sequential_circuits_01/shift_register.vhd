   
   --- design name - : shift_register
   --- DESIGNER    - : Jogesh singh
   
   
   
   library IEEE ;
   use ieee.std_logic_unsigned.all;
   use ieee.std_logic_1164.all    ;
   
   
   ----------------------------------------------------------
   
   -- entity declaration
   
   -----------------------------------------------------------
   
   entity shift_register is 
   port 
       (
	     i_clk        : in  std_logic  ;
		 i_rst        : in  std_logic  ;
		 i_din        : in  std_logic  ;
		 i_shift_en   : in  std_logic  ;
	     o_shift_left : out std_logic  ; 
         o_shift_right: out std_logic  
		);
    end entity shift_register ;
	
	
	---------------------------------------------------------
	
    -- architecture definition
   
   ----------------------------------------------------------
   
   architecture shift_behav_rtl of shift_register is 
   
    -- signal declaration
	
	
	signal shift_reg_left : std_logic_vector(3 downto 0) ;
	signal shift_reg_right: std_logic_vector(3 downto 0) ;
	signal shift_nxt_right: std_logic_vector(3 downto 0) ;
	signal shift_nxt_left : std_logic_vector(3 downto 0) ;
	
   
    begin
	
	
	    -- rtl reg 
		
		 rtl_proc : process (i_clk)
		  begin
		            if (i_rst = '0') then
					 shift_reg_left  <= (others => '0');
					 shift_reg_right <= (others => '0');
					elsif(rising_edge (i_clk)) then
					 shift_reg_left  <= shift_nxt_left ;
					 shift_reg_right <= shift_nxt_right;
					end if ;
	    end process rtl_proc ;
		
		
		-- next state logic 
		
	    -- left shift operation	
	   
          shift_nxt_left <= (others => '0') when (i_shift_en = '0') else
                         shift_reg_left(2 downto 0) & i_din when (i_shift_en = '1');
   
        -- right shift operation 
		
		  shift_nxt_right <= (others  =>  '0') when (i_shift_en = '1') else
		                      i_din & shift_reg_right(3 downto 1 ) when (i_shift_en = '0') ;

        -- assign output 
		
		o_shift_left  <= shift_reg_left(3); 
		
		o_shift_right <= shift_reg_right(0) ;
		
		
end architecture shift_behav_rtl ;