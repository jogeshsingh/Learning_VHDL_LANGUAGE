-----Design name --- MUX_4_1_case_behav 
-----Description
---- 4 to 1 mux is designed using Case Statements in VHDL 


library IEEE ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;


--entity Declaration

entity MUX_4_1_case_behav is 
  port 
   (
    i_in  : in std_logic_vector (3 downto 0) ;
    i_sel : in std_logic_vector (1 downto 0) ;
    o_out : out std_logic   
   );

end entity MUX_4_1_case_behav  ;

---architecture definition

architecture LOGIC_4_1_MUX of MUX_4_1_case_behav is 
  begin
        C_CASE_PROCESS : process (i_in , i_sel)
                 begin
                        case i_sel is 
               when "00"    => o_out <= i_in(0) ;
               when "01"    => o_out <= i_in(1) ;
               when "10"    => o_out <= i_in(2) ;
               when "11"    => o_out <= i_in(3) ;
               when others  => o_out <= '0' ;
               end case  ;          --- end case
  end process ;                   ---end process
end LOGIC_4_1_MUX;                ---end architecture 
