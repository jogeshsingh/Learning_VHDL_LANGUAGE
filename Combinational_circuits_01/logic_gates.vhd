-------------- Let's learn VHDL ----------------
---------------combinational Circuits 
---------------LOGIC GATES 


library IEEE ;
use IEEE.std_logic_1164.all ;


entity logic_gates  is 
 port(
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

 end logic_gates ;

 architecture logic_rtl of logic_gates is 
 begin
     out_and    <= in_1 and in_2  ;
     out_or     <= in_1 or in_2   ;
     out_nand   <= in_1 nand in_2 ;
     out_nor    <= in_1 nor in_2  ;
     out_xor    <= in_1 xor in_2  ; 
     out_not_1  <= not in_1         ;
     out_not_2  <= not in_2         ;
 end logic_rtl ; 
