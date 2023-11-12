  
  
  ----------------------------------------------------------
  --Design name : Unasigned muliplier
 -- HDL         : VHDL
  ----------------------------------------------------------
  
  library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.std_logic_unsigned.all;
  
  
  -- entity declaration
  
  entity unsigned_multiplier is 
  generic 
   (
     WIDTH_A : integer := 16 ;
	 WIDTH_B : integer := 8 
   ) ;       
  port

    (
	 i_a     : in std_logic_vector(WIDTH_A-1 downto 0);
	 i_b     : in std_logic_vector(WIDTH_B-1 downto 0) ;
	 o_out   : out std_logic_vector((WIDTH_A + WIDTH_B)-1 downto 0) 
	 );
  
 end entity unsigned_multiplier  ;

  -- architecture definition

   architecture behav_rtl of unsigned_multiplier is 
     
    begin
 
     o_out <= i_a * i_b ; 

    end behav_rtl ;	 
