---------------------------------------------------------
---- Design name : Sender_logic
---- HDL         : VHDL 
---- Handshake logic 
---- CLK DOMAIN A and CLK DOMAIN B 
---- CLK DOMAIN A - faster 
---- CLK DOMAIN B - slower 
---------------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL ;


---------------------------------------------------------
-- entity declaration
---------------------------------------------------------

entity Sender_logic is 
generic ( N_WIDTH : integer := 8);
port 
    (
	  i_clk_a : in std_logic  ;
	  i_rst_n : in std_logic  ;
	  i_en    : in std_logic  ;
	  i_data  : in std_logic_vector (N_WIDTH-1 downto 0) ;
	  i_ack   : in std_logic  ;
	  o_data  : out std_logic_vector (N_WIDTH-1 downto 0) ;
	  o_req   : out std_logic 
	);
	

end entity Sender_logic ;



------------------------------------------------------
-- architecture definition
------------------------------------------------------


architecture behav_rtl of Sender_logic is 


------------------------------------------------------
-- signal declaration
------------------------------------------------------

signal data_latch : std_logic_vector ( N_WIDTH-1 downto 0) := (others => '0') ;
signal ack_reg  : std_logic := '0' ;
signal req_reg  : std_logic := '0' ;

signal fsm_en   : std_logic := '0' ;

type state_type is (idle_req , wait_ack_high , wait_ack_low ) ;
signal p_state  : state_type              ;

------------------------------------------------
-- latch the data 
------------------------------------------------
begin
proc_latch_data : process (i_clk_a) 
 begin 
            if (rising_edge(i_clk_a)) then 
			      if (i_rst_n = '0') then
			       data_latch <= (others => '0') ;
			       fsm_en     <= '0' ;
			  elsif(i_en = '1') then 
			       data_latch <= i_data ;
			       fsm_en     <= '1'    ;
			  elsif(p_state = wait_ack_high)then 
			       fsm_en     <= '0' ;
			end if ;
	   end if ;
end process proc_latch_data                ;


------------------------------------------------------
-- latch the receiver 
-- clock signal acknowledgement
------------------------------------------------------

proc_latch_ack : process (i_clk_a)
 begin
       if (rising_edge(i_clk_a)) then 
	      if (i_rst_n = '0') then 
		      ack_reg <= '0'                          ;
		  else 
		      ack_reg <= i_ack                        ;
		end if                                        ;
    end if                                            ;
end process proc_latch_ack                            ;
			   
-------------------------------------------------------
-- request signal generation
-------------------------------------------------------

rtl_proc_reg : process (i_clk_a)
 begin
           if (rising_edge(i_clk_a)) then 
		          if (i_rst_n = '0') then 
				            req_reg      <= '0'       ;
					        p_state      <= idle_req  ;
				 else
				        case p_state is 
         
           when idle_req => if (fsm_en = '1') then 
                            req_reg      <= '1'       ;
                            p_state      <= wait_ack_high  ;
                            else
                            p_state      <= idle_req  ;
                            end if                     ;
          
           when wait_ack_high => if (ack_reg = '1') then
                                p_state  <= wait_ack_low  ;
								        req_reg  <= '0'       ;
                            else
                                p_state  <= wait_ack_high  ;
                                req_reg  <= req_reg   ;
                            end if                    ;								

           when wait_ack_low => if (ack_reg = '0') then
                                p_state  <= idle_req  ;
								        req_reg  <= '0'       ;
                            else
                                p_state  <= wait_ack_low  ;
                                req_reg  <= req_reg   ;
                            end if                    ;	

   
            when others =>  p_state <= idle_req       ;
			end case                                  ;
		end if                                        ;
	end if                                            ;
 end process rtl_proc_reg                             ;



 ------------------------------------------------------
 --- output 
 ------------------------------------------------------

 o_req  <= req_reg                                     ;
 o_data <= data_latch                                  ;

 end architecture  behav_rtl                           ;