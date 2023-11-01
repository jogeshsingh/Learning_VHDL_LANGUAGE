----Design name --- MUX_4_1_IF_BEHAV
----Description ----
--- 4 to 1 mux is designed using IF/elsif statements in VHDL
---- inputs       = 4 
----- data width  = 1
---- sel line     = 2
----- output port = 1 

library IEEE ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;

-- entity declarations

entity MUX_4_1_IF_BEHAV is 
 port 
   ( 
    i_in  : in std_logic_vector (3 downto 0) ;
    i_sel : in std_logic_vector (1 downto 0) ;
    o_out : out std_logic   

   ) ;

end entity MUX_4_1_IF_BEHAV ;

--- architecture

architecture logic_design_mux_4_1 of MUX_4_1_IF_BEHAV is
   begin
      C_MUX_4_1 : process (i_in , i_sel )
             begin
                  if (i_sel = "00") then 
                          o_out <= i_in(0) ;
                  elsif (i_sel = "01" ) then
                          o_out <= i_in(1) ;
                  elsif ( i_sel = "10") then
                          o_out <= i_in(2) ;
                  elsif (i_sel = "11")then
                          o_out <= i_in(3) ;
                  else
                          o_out <= '0' ;
                  end if ;
   end process ;
   end logic_design_mux_4_1 ;

   --- end process
   --- end architecture
   

