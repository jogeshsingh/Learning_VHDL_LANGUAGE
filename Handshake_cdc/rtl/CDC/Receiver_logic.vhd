------------------------------------------------------
---- Design name : Receiver_logic
---- HDL         : VHDL 
---- Handshake logic 
---- CLK DOMAIN A and CLK DOMAIN B 
---- CLK DOMAIN A - faster 
---- CLK DOMAIN B - slower 
-----------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL ;


-----------------------------------------------------
-- entity declaration
-----------------------------------------------------

entity Receiver_logic is 
generic (
         D_WIDTH : integer := 16
		);
port 
    (
	  i_clk_b : in std_logic ;
	  i_rst_n : in std_logic ;
	  i_data  : in std_logic_vector(D_WIDTH-1 downto 0) ;
	  o_data  : out std_logic_vector(D_WIDTH-1 downto 0) ;
	  i_req   : in std_logic ;
	  o_ack   : out std_logic 
	
	);
end entity Receiver_logic ;

------------------------------------------------------
-- architecture definition
------------------------------------------------------

architecture behav_rtl of Receiver_logic is 

------------------------------------------------------
-- signal declaration
------------------------------------------------------

signal ack_reg      : std_logic := '0'                  ;
signal req_reg      : std_logic := '0'                  ;
signal latch_d      : std_logic_vector(D_WIDTH-1 downto 0) := (others => '0')      ;
signal latch_dat_en : std_logic := '0'                  ;

type state_type is (idle_latch_req , latch_data)             ;
signal p_state      : state_type                        ;

------------------------------------------------------
-- latch data 
------------------------------------------------------
begin

rtl_latch_data : process (i_clk_b)
 begin
             if (falling_edge(i_clk_b)) then 
			       if (i_rst_n = '0') then 
				       latch_d <= (others => '0')                 ;
				   elsif (latch_dat_en = '1' ) then             
				       latch_d <= i_data                          ;
			end if                                                ;
		end if                                                    ;
end process rtl_latch_data                                        ;

------------------------------------------------------
-- latch the sender 
-- clock signal request
------------------------------------------------------

proc_latch_ack : process (i_clk_b)
 begin
       if (rising_edge(i_clk_b)) then 
	      if (i_rst_n = '0') then 
		      req_reg <= '0'                                      ;
		  elsif (latch_dat_en = '1') then 
		      req_reg <= '0'                                      ;
		   else                                                   
		      req_reg <= i_req                                    ;
		end if                                                    ;
    end if                                                        ;
end process proc_latch_ack                                        ;
			   			   
-------------------------------------------------------
-- handshake logic 
-------------------------------------------------------

 latch_dat_en <= '1' when (req_reg = '1' and ack_reg = '1')
                     else '0'                                     ; 
			   			   
-------------------------------------------------------
-- request signal generation
-------------------------------------------------------

 rtl_proc_reg : process (i_clk_b)
  begin
           if (rising_edge(i_clk_b)) then 
		          if (i_rst_n = '0') then 
				            ack_reg      <= '0'                   ;
					        p_state      <= idle_latch_req        ;
				 else
				        case p_state is 
         
           when idle_latch_req => if (req_reg = '1') then 
		                               ack_reg  <= '1'            ;
                                       p_state  <= latch_data     ;
								  else
								       p_state  <= idle_latch_req ;
							     end if                           ;
								  
           when latch_data  =>  ack_reg  <= '0'                   ;
                                p_state  <= idle_latch_req        ;
                            							

            when others =>  p_state <= idle_latch_req             ;
			end case                                              ;
		end if                                                    ;
	end if                                                        ;
 end process rtl_proc_reg                                         ;

 -----------------------------------------------------------------
 --- output 
 -----------------------------------------------------------------

 o_ack  <= ack_reg                                                ;
 o_data <= latch_d                                                ;
 
 ----------------------------------------------------------------
 

 end architecture behav_rtl                                 ;