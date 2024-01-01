----------------------------------------------------------------------------------
-- Engineer: Jogesh Singh 
-- Design Name: 
-- Module Name: seq_detect_1011_non_overlapping - Behavioral - mealy machine
-- In mealy machine output depends on the current state and inputs 
-- while in moore machine output depends on the current state only

-- Note the following -:

-- for mealy machine

-- in non-overlapping case for mealy machine the last bit is moved to reset state 
-- in 1-bit overlapping case for mealy machine the last 1 bit is compared to 1 bit state 
-- in 2-bit overlapping case for moore machine the last 2 bits are compared to 2 bit state

-- For moore machine

-- in non-overlapping case for moore machine the last 1 bit is comapred to 1 bit state  
-- in 1-bit overlapping case for mealy machine the last 2 bits are compared to 2 bit state 
-- in 2-bit overlapping case for moore machine the last 3 bits are compared to 3 bit state
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;


---------------------------------------------------------------------------------
-- entity declaration
---------------------------------------------------------------------------------
entity seq_detect_1011_non_overlapping is
port (
      input_i : in std_logic ;
      i_rst_n : in std_logic ;
      i_clk   : in std_logic ;
      out_seq : out std_logic 
      );
end entity seq_detect_1011_non_overlapping;


--------------------------------------------------------------------------------
-- architecture definition
--------------------------------------------------------------------------------
architecture Behavioral of seq_detect_1011_non_overlapping is


type   state_type is (s0 , s1, s2, s3);
signal current_state , next_state : state_type ;

signal rst_cnt : std_logic_vector (1 downto 0) ;
signal a_rst   : std_logic ;
signal reset   : std_logic ;

 
begin

  a_rst <= not (i_rst_n) ;                                 
  reset <= '0' when rst_cnt = 3 else '1' ;       -- deasserted the reset after counter reaches a particular count  
  
  ---  process 
  ---  rising edge of clock is used 
  ---  Asynchronous reset is used   
  ---  circuit is reseted w.r.t to i_rst_n (active-low-reset)
  
  
process (i_clk , a_rst) 
  begin
      if (a_rst = '1') then  
         rst_cnt <= (others => '0');
      elsif (rising_edge(i_clk)) then 
         if (rst_cnt <3) then
             rst_cnt <= rst_cnt + 1 ;
         else
             rst_cnt <= rst_cnt ;
         end if ;
      end if ;
 end process ;
  
  
  --- data register
  
process(i_clk , reset) 
  begin
       if (reset = '1') then
         current_state <= s0;
       elsif (rising_edge (i_clk))then 
         current_state <=  next_state ;
       end if ;
   end process ; 
   
   
   
 --- next state logic 
 --- process
 
 
 process (input_i , current_state)
 begin
      case current_state is 
           when s0 => if (input_i = '1')then 
                       next_state <= s1 ;
                       out_seq    <= '0';
                      else  
                       next_state <= s0  ;
                       out_seq   <=  '0';
                      end if ;
                      
           when s1 =>  if (input_i = '1') then 
                         next_state <= s1 ;
                         out_seq    <= '0';
                       else 
                         next_state <=  s2 ;
                         out_seq    <= '0';
                       end if ;
                       
           when s2 =>  if (input_i = '1')then
                        next_state <= s3 ;
                        out_seq    <= '0';
                       else 
                        next_state <= s0 ;
                        out_seq    <= '0';
                      end if ;
                      
           when s3  => if (input_i = '0') then 
                         next_state <= s0  ;
                         out_seq    <= '0';
                        else
                         next_state <= s0;
                         out_seq    <= '1';
                       end if ;
          end case ;
    end process ;                   
        
 
end Behavioral;
