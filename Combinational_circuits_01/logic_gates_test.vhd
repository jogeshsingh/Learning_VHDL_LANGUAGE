-----------let's write testbench for logic gates 

library IEEE;
use ieee.std_logic_1164.all ;

entity logic_gates_test is 
end entity ;

architecture logic_rtl of logic_gates_test is 
component logic_gates is 
port (
    in_1      : in std_logic  ;
    in_2      : in std_logic  ;
    out_and   : out std_logic ;
    out_or    : out std_logic ;
    out_nor   : out std_logic ;
    out_nand  : out std_logic ;
    out_xor   : out std_logic ;
    out_not_1 : out std_logic ;
    out_not_2 : out std_logic 
);

end component  ;

signal i_1 , i_2 : std_logic ;
signal or_g      : std_logic ;
signal and_g     : std_logic ;
signal xor_g     : std_logic ;
signal nand_g    : std_logic ;
signal not_g_1   : std_logic ;
signal not_g_2   : std_logic ;
signal nor_g     : std_logic ;


begin
     
   DUT : logic_gates port map 
   (
    in_1      =>  i_1     ,
    in_2      =>  i_2     ,          
    out_and   =>  and_g   ,          
    out_or    =>  or_g    ,          
    out_nor   =>  nor_g   ,          
    out_nand  =>  nand_g  ,
    out_xor   =>  xor_g   ,
    out_not_1 =>  not_g_1 ,  
    out_not_2 =>  not_g_2   
   );

   stimulus : process 
   begin
     i_1 <= '0' ;
     i_2 <= '0' ;
     wait for 10 ns ;

     i_1 <= '0' ;
     i_2 <= '1' ;
     wait for 10 ns ;

     i_1 <= '1' ;
     i_2 <= '0' ;
     wait for 10 ns ;

     i_1 <= '1' ;
     i_2 <= '1' ;
     wait for 10 ns ;

     i_1 <= '1' ;
     i_2 <= '0' ;
     wait for 10 ns ;

     i_1 <= '0' ;
     i_2 <= '1' ;
     wait for 10 ns ;


     i_1 <= '1' ;
     i_2 <= '1' ;
     wait for 10 ns ;

     i_1 <= '1' ;
     i_2 <= '0' ;
     wait for 10 ns ;

     i_1 <= '1' ;
     i_2 <= '1' ;
     wait for 10 ns ;

     i_1 <= '0' ;
     i_2 <= '0' ;
     wait for 10 ns ;

   end process ;
end logic_rtl ;


      

