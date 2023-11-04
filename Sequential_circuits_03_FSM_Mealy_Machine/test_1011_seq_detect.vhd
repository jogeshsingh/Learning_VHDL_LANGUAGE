----------------------------------------------------------------------------------
-- Engineer: Jogesh Singh
-- Design  : test_1011_seq_detect
-- HDL     : VHDL 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_1011_seq_detect is
end test_1011_seq_detect;

architecture Behavioral of test_1011_seq_detect is

 --- componen declaration
 component   seq_detect_1011_non_overlapping is
   port (
         input_i : in std_logic ;
         i_rst_n : in std_logic ;
         i_clk   : in std_logic ;
         out_seq : out std_logic 
        );
 end component ;    
 
  ---  test signals 
 
 signal in_i   : std_logic ;
 signal clk    : std_logic ;
 signal reset  : std_logic ;
 signal out_seq: std_logic ;
 
 ------------------------------------------------------------- 
 begin
 --- instantiate design under test 
 DUT : seq_detect_1011_non_overlapping  port map (
                                      input_i =>  in_i   , 
                                      i_rst_n =>  reset  , 
                                      i_clk   =>  clk    ,
                                      out_seq =>  out_seq  
                                    );
 --------------------------------------------------------------                                    
 --- stimulus for providing the input
 stimulus_process : process
    begin
        wait until (reset = '1') ;
        wait for 150 ns ;
        in_i  <= '1' ; wait for 60 ns ;
        in_i  <= '0' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
        in_i  <= '0' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
        in_i  <= '0' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
       wait ;
    end process ;
  -----------------------------------------------------------------   
  ---  clock process
  ---  generating the clock
  clock_process : process
  begin
        clk <= '0' ; wait for 5 ns ;
        clk <= '1' ; wait for 5 ns ;
  end process ;
  ---------------------------------------------------------------------
  -- reset process 
  -- generating the reset 
  reset_process : process
  begin
        reset <= '0' ; wait for 300 ns ;
        reset <= '1' ; wait for 300 ns ;
      wait ;
  end process ;
        
end Behavioral;
