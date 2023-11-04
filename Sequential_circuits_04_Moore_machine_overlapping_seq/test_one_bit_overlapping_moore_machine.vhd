---------------------------------------------------------------------
--- Design   : Testbench for one_bit_overlapping_moore_machine
--- Designer : Jogesh Singh
--- HDL      : VHDL
-----------------------------------------------------------------------


library IEEE ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;


entity test_one_bit_overlapping_moore_machine is
end entity test_one_bit_overlapping_moore_machine;



architecture testbench_1101 of test_one_bit_overlapping_moore_machine is

--- component declaration 
---

component one_bit_overlapping_moore_machine is 
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

end component one_bit_overlapping_moore_machine ;

  ---  test signals 
 
 signal in_i   : std_logic ;
 signal clk    : std_logic ;
 signal reset  : std_logic ;
 signal out_s  : std_logic ;
 
 ------------------------------------------------------------- 
 begin
 --- instantiate design under test 
 
 
 DUT : one_bit_overlapping_moore_machine   port map (
                                      i_clk    =>  clk   , 
                                      i_rst_n  =>  reset , 
                                      i_in_seq  => in_i  ,
                                      o_seq    =>  out_s 
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
        in_i  <= '1' ; wait for 10 ns ;
        in_i  <= '0' ; wait for 10 ns ;
        in_i  <= '1' ; wait for 10 ns ;
		in_i  <= '0' ; wait for 10 ns ;
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
        
end testbench_1101;
