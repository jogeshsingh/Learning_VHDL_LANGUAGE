------------------------------------------------------
---- Design name : Top_handshake_data_logic
---- HDL         : VHDL 
---- CLK DOMAIN A and CLK DOMAIN B 
---- CLK DOMAIN A - faster 
---- CLK DOMAIN B - slower 
-----------------------------------------------------

library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;
use IEEE.NUMERIC_STD.ALL ;



entity Top_handshake_data_logic  is 
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
end entity Top_handshake_data_logic  ;



architecture behav_rtl of Top_handshake_data_logic is 

--------------------------------
-- component declaration
--------------------------------

 ---------------
 -- sender fsm 
 ---------------
 
 component Sender_logic is 
 generic ( N_WIDTH : integer := 8);
 port(
	  i_clk_a : in std_logic  ;
	  i_rst_n : in std_logic  ;
	  i_en    : in std_logic  ;
	  i_data  : in std_logic_vector (N_WIDTH-1 downto 0) ;
	  i_ack   : in std_logic  ;
	  o_data  : out std_logic_vector (N_WIDTH-1 downto 0) ;
	  o_req   : out std_logic 
	);
	
 end component ;
 
 -----------------
 -- receiver fsm 
 -----------------
 
 component receiver_logic is 
 generic (
          D_WIDTH : integer := 16
		 );
 port 
      (
	  i_clk_b : in std_logic                             ;
	  i_rst_n : in std_logic                             ;
	  i_data  : in std_logic_vector(D_WIDTH-1 downto 0)  ;
	  o_data  : out std_logic_vector(D_WIDTH-1 downto 0) ;
	  i_req   : in std_logic                             ;
	  o_ack   : out std_logic 
	  );
 end component Receiver_logic  ;
 
 -------------------------
 ----- signal declaration
 -------------------------
 
 signal o_dat_clk_a : std_logic_vector (DATA_WIDTH-1 downto 0) := (others => '0') ;
 signal o_ack       : std_logic := '0' ;
 signal o_req       : std_logic := '0' ;


 begin
 
 ----------------------
 --- instantiate 
 --- sender logic fsm
 -----------------------		 

  FSM_SEND_DAT_UO : Sender_logic  
 generic map( N_WIDTH => DATA_WIDTH)
 port map (
	    i_clk_a =>  i_clk_a       ,
	    i_rst_n =>  i_rst_n       , 
	    i_en    =>  i_dat_valid   , 
	    i_data  =>  i_data        , 
	    i_ack   =>  o_ack         , 
	    o_data  =>  o_dat_clk_a   , 
	    o_req   =>  o_req         
	  );
	
	
 FSM_RECEIVE_DAT_U1 : receiver_logic 
 generic map ( D_WIDTH =>  DATA_WIDTH )
 port map (
	       i_clk_b =>   i_clk_b     , 
	       i_rst_n =>   i_rst_n     , 
	       i_data  =>   o_dat_clk_a , 
	       o_data  =>   o_data      , 
	       i_req   =>   o_req       , 
	       o_ack   =>   o_ack   
	      );

	
end architecture behav_rtl          ;