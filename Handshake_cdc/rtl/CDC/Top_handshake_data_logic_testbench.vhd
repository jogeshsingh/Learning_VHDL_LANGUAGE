------------------------------------------------------
---- Design name : Top_handshake_data_logic_testbench
---- HDL         : VHDL 
---- CLK DOMAIN A and CLK DOMAIN B 
---- CLK DOMAIN A - faster 
---- CLK DOMAIN B - slower 
-----------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL ;


entity Top_handshake_data_logic_testbench is 
end entity Top_handshake_data_logic_testbench ;



architecture behav_test of Top_handshake_data_logic_testbench is 

--------------------------
-- component declaration
--------------------------

component Top_handshake_data_logic  is 
generic (
         DATA_WIDTH  : integer := 16
		);
port 
       (
	     i_clk_a     : in std_logic ;
		 i_clk_b     : in std_logic ;
		 i_rst_n     : in std_logic ;
		 i_dat_valid : in std_logic ;
		 i_data      : in std_logic_vector (DATA_WIDTH -1 downto 0) ;
		 o_data      : out std_logic_vector(DATA_WIDTH -1 downto 0)
		);
end component  ;


-------------------------------
-- signal declaration
-------------------------------

-- constant 

constant DATA_W : integer := 16 ;

-- signals

 signal i_clk_a       :   std_logic                                 ;
 signal i_clk_b       :   std_logic                                 ;
 signal i_rst_n       :   std_logic                                 ;
 signal i_data_valid   :   std_logic                                 ;
 signal i_data        :   std_logic_vector (DATA_W -1 downto 0) ;
 signal o_data        :   std_logic_vector (DATA_W -1 downto 0) ;


begin

--------------------
-- DUT 
--------------------
  

  
 DUT : Top_handshake_data_logic   
 generic map (
         DATA_WIDTH  => DATA_W
		)
 port map(
	     i_clk_a     =>   i_clk_a     , 
		 i_clk_b     =>   i_clk_b     , 
		 i_rst_n     =>   i_rst_n     , 
		 i_dat_valid =>   i_data_valid , 
		 i_data      =>   i_data      , 
		 o_data      =>   o_data      
	);

-----------------
--clock process 
-----------------	
	clk_proc_a : process 
	begin
	    wait for 5 ns ;
		i_clk_a <= '0'  ;
		wait for 5 ns ;
		i_clk_a <= '1'  ; 
    end process clk_proc_a ;
	
	
	clk_proc_b : process 
	begin
	    wait for 20 ns ;
		i_clk_b <= '0'  ;
		wait for 20 ns ;
		i_clk_b <= '1'  ; 
    end process clk_proc_b ;
	
-------------------	
-- reset processs
-------------------
	
	rst_proc : process
	 begin
	    wait for 15 ns ;
		i_rst_n  <= '1' ;
	 end process rst_proc ;


--------------------
-- Data generation 
-- 
--------------------

    dat_gen_proc : process
	   begin
	       wait for 18 ns ;
		    i_data_valid <= '1' ;
			i_data      <=  x"1234";
		   wait for 10 ns ;
		    i_data_valid <= '0' ;
		wait for 80 ns ;
		    i_data_valid <= '1' ;
			i_data       <= x"45AC";
		wait for 10 ns ;
		    i_data_valid <= '0' ;
	    wait ;
    end process dat_gen_proc  ;		
			
			
end architecture behav_test ;		
		












