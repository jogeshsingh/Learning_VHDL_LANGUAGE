----------------------------------------------------------------------------------
-- Design Positive_edge_detector 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- entity declaration

entity posedge_detector is

Port ( 
       i_clk         : in  std_logic ;
	   i_rst_n       : in  std_logic ; 
       i_din         : in  std_logic ;
       o_edge_detect : out std_logic    
   
   );
end posedge_detector;

--architecture definition

architecture Behavioral of posedge_detector is

-- signal declaration
 signal not_gate : std_logic := '0' ;
 signal d_ff     : std_logic := '0' ;


begin

    -------------------------------------------
    -- rtl register 
	-------------------------------------------
	 rtl_reg_proc : process (i_clk)
	   begin
	        if (rising_edge(i_clk)) then
			     if (i_rst_n = '0') then
				     d_ff <= '0'            ; 
			     else
				     d_ff <= i_din          ;
	          end if                        ;
			end if                          ;
		end process rtl_reg_proc            ;
		
		
		------------------------------------
		-- output block
		--------------------------------------

        not_gate <= not d_ff ;
		o_edge_detect <= not_gate and i_din ;
		
		-------------------------------------
		--- end architecture
		
end Behavioral;
