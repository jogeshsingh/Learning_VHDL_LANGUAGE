----------------------------------------------------------------------
--- Design name : Sequence detector 1011 non-overlapping case moore machine
--- Designer    : Jogesh Singh
--- HDL         : VHDL
--- Description : The last bit in the sequence is compared to 1 bit state and 1 extra state is required in moore fsm
----------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;

----------------------------------------------------------------------

-- entity declaration

----------------------------------------------------------------------

entity one_bit_overlapping_moore_machine is 
generic 
  (
    SYNC_STAGES : integer  := 2                              -- number of synchronizing registers
  );
port
   ( 
     i_clk    : in  std_logic ;
	 i_rst_n  : in  std_logic ;
	 i_in_seq : in  std_logic ;
	 o_seq    : out std_logic 
    ) ;

end entity one_bit_overlapping_moore_machine ;


---------------------------------------------------------------------

-- architecture definition

---------------------------------------------------------------------

architecture  behav_1101_rtl of one_bit_overlapping_moore_machine is

-- signal declaration
-- fsm state declaration
-- using enumerated types 

type state_type is (s_0 , s_1  , s_2 , s_3 ,s_4)     ;
signal p_state , n_state : state_type                ;

-- synchronized reset signal
signal sync_rst_sig    : std_logic                 ;  

-- output register signal
signal out_reg           : std_logic               ;	

-- The following represents the initial value of synchronizer register
-- it is `1` incase there is active low(0) reset
-- and `0` incase if there is active high(1) reset
 
signal INIT_VAL          : std_logic := '1'        ;       

-- sync_registers declaration

signal rst_reg : std_logic_vector(SYNC_STAGES-1 downto 0) ;               -- used for 2 flip flops for synchronization purpose of i_rst_signal

--------------------------------------------------------------------
-- We will use ASYNC_REG = "TRUE" attribute 
-- This specifies registers will receive asynchronous input
-- and will allow tools to improve metastability 

-- Synchronize the asynchronous reset input signal 
-- to reduce the probability of metastability in a circuit 
--------------------------------------------------------------------

attribute async_reg : string ;
attribute async_reg of rst_reg : signal is "true" ;

--------------------------------------------------------------------
begin

SYNC_RST_PROC : process (i_clk , i_rst_n)
begin
         if (i_clk'event and i_clk = '1') then
		      if (i_rst_n = '0') then
			    rst_reg <= (others => '0') ;
		      else
			    rst_reg <= rst_reg(SYNC_STAGES-2 downto 0) & INIT_VAL ;
			end if ;
	   end if ;
end process SYNC_RST_PROC ;


------------------------------------------------------------------
-- assign the rst_reg msb to sync_rst_sig signal 
-- here rst_n is a synchronized reset signal
------------------------------------------------------------------

sync_rst_sig  <= rst_reg(SYNC_STAGES-1) ;


-- State register 

SYNC_PROC: process (i_clk , sync_rst_sig)
   begin
      if (i_clk'event and i_clk = '1') then
         if (sync_rst_sig = '0') then
            p_state  <= s_0;
            o_seq    <= '0';
         else
            p_state <= n_state;
            o_seq   <= out_reg;
         end if;
      end if;
   end process;
   
 --MOORE State-Machine - Outputs based on state only
 
 OUTPUT_DECODE: process (p_state)
   begin
      if p_state = s_4 then
         out_reg <= '1';
      else
         out_reg <= '0';
      end if;
   end process;

 -- NEXT State logic 
 
 NEXT_STATE_DECODE: process (p_state, i_in_seq)
   begin
      --declare default state for next_state to avoid latches
      n_state <= p_state;  --default is to stay in current state

     case (p_state) is
         when s_0 =>  if i_in_seq = '1' then
		               n_state <= s_1 ;
	                  else
		               n_state <= s_0 ;
					  end if  ;
					   
	     when s_1 =>  if i_in_seq = '1' then
		               n_state  <= s_2 ;
		              else 
		               n_state  <= s_0 ;
		              end if ;
					  
		 when s_2 =>  if i_in_seq = '1' then
		               n_state <= s_2 ;
		              else
		               n_state <= s_3 ;
					  end if ;
		 
		 when s_3 => if i_in_seq = '1' then
			           n_state <= s_4 ;
		              else 
		               n_state <= s_0 ;
					  end if ;
	     
		 when s_4 =>  if i_in_seq = '1' then
 		               n_state <= s_2;
			          else
			           n_state <= s_0;
					  end if ;
					  
		 when others => n_state <= s_0 ;
      end case;
   end process;

end behav_1101_rtl ;			
			