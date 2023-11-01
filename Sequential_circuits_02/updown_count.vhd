
-------------------------------------------------------------------------
--- Design   -: updown_count
--- Designer -: Jogesh singh
-------------------------------------------------------------------------

 library IEEE;
 use ieee.std_logic_1164.all;
 --use ieee.numeric_std.all ;
 use IEEE.STD_LOGIC_ARITH.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL ;
 
   -----------------------------------------------------------------------------------
   -- entity declaration
   -----------------------------------------------------------------------------------
 entity updown_count is 
 generic (
    width  : integer := 32 
	);
 port 
    (
	  i_clk    : in  std_logic        ;                                    -- fpga clock
	  i_rst    : in  std_logic        ;                                    -- active low reset
	  i_cnt_en : in  std_logic        ;                                    -- signal for enabling up(1) and down(0) count operation
	  o_cnt    : out std_logic_vector (width - 1 downto 0)                -- output count operation 
	);
	
 end entity updown_count ;
    ---------------------------------------------------------------------------------	
	-- architecture definition
	---------------------------------------------------------------------------------
	
 architecture behav_counter of updown_count is 
	
	-- signal declaration
	
	signal count_reg : std_logic_vector(width-1 downto 0) ;
		
	begin
	 
	    -- rtl process 
		-- register 
		
		rtl_proc  : process (i_clk)
		begin
		           if (i_rst='0') then 
				        count_reg <= (others => '0')          ;
				   elsif (i_clk'event and i_clk = '1')then 
				        if (i_cnt_en = '0') then
						count_reg <= count_reg + 1              ;
						else
					    count_reg <= count_reg - 1             ;
					end if                                     ;
				end if                                        ;
	  end process  rtl_proc                                ;
		
		-- output logic 
        
      o_cnt <= count_reg ;		
				
					
 end architecture behav_counter                           ;				
	
	
	
	
	