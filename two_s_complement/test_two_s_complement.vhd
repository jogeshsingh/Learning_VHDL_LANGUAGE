---------------------------------------
---- Design name : test_two_s_complement
---- HDL         : VHDL 
--------------------------------------

library IEEE                    ;
use IEEE.STD_LOGIC_1164.ALL     ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL        ;



entity test_two_s_complement is 
end entity test_two_s_complement ;


architecture rtl_test of test_two_s_complement is 

-- constant declaration 
constant WIDTH_NN : natural := 16 ;


-- component declaration

component TWO_S_COMPLEMENT is 
 generic 
         (
		   WIDTH_N : natural := 15
		  ) ;
 port 
          (
		   i_input         : in std_logic_vector  ((WIDTH_N-1) downto 0);
		   o_output        : out std_logic_vector ((WIDTH_N-1) downto 0)
		  -- o_verify_result : out std_logic_vector ((WIDTH_N-1) downto 0)
		   ) ;
end component ;


-- signal declaration 

signal i_in          : std_logic_vector (WIDTH_NN -1 downto 0) := (others => '0') ;
signal o_out         : std_logic_vector (WIDTH_NN -1 downto 0) := (others => '0') ;
signal check_result  : std_logic_vector (WIDTH_NN -1 downto 0) := (others => '0') ;
signal data          : std_logic_vector (WIDTH_NN -1 downto 0) := (others => '0') ; 
signal i_clk         : std_logic := '0'                                           ;
signal rst           : std_logic := '0'                                           ;

begin



    DUT_1_CALCULATE_TWO_S_COMPLEMENT  : TWO_S_COMPLEMENT  
      generic map(
		 WIDTH_N => WIDTH_NN
         ) 
      port map   (
		        i_input   => i_in ,
		        o_output  => o_out 
		         ) ;
		   
	DUT_2_CHECK_2_S_COMPLEMENT_RESULT  : TWO_S_COMPLEMENT  
      generic map(
		  WIDTH_N => WIDTH_NN
		  ) 
      port map   (
		        i_input   => o_out ,
		        o_output  => check_result 
		        ) ;
		   
		   
		   
    clk_gen_proc : process 
     begin
              wait for 10 ns ;
               i_clk  <= '0' ;
              wait for 10 ns ;
               i_clk  <= '1' ;
    end process clk_gen_proc ;
	  
	
    reset_gen_proc : process 
     begin
            wait for 25 ns     ;
             rst <= '1'        ;
    end process reset_gen_proc ;			 
		   
		   
  test_vector_proc : process(i_clk )
          variable temp_data : unsigned(WIDTH_NN -1 downto 0) ;  
		  begin
		         if (rising_edge(i_clk)) then 
				   if (rst = '0') then 
				    temp_data := (others => '0') ;
				  else
				    temp_data := temp_data + 1   ;
				end if                           ;
			end if                               ;
			i_in <= std_logic_vector(temp_data)  ;
  end process test_vector_proc                   ;
		   
		   
 end architecture rtl_test                       ;		   