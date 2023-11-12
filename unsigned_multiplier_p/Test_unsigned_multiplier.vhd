 ------------------------------------------------
 
 --- Design name : Test_unsigned_multiplier
 
 ------------------------------------------------
 
  library IEEE ;
  use IEEE.std_logic_1164.all ;
  use IEEE.std_logic_unsigned.all;
  
  
  entity Test_unsigned_multiplier is
  end entity Test_unsigned_multiplier ;
  
  
  
  architecture Test_rtl of test_unsigned_multiplier  is
    
	constant WIDTH_A : integer := 16;
   constant WIDTH_B : integer := 8;

	
	-- component declaration
	component unsigned_multiplier is 
  generic 
   (
     WIDTH_A : integer := 16;
	 WIDTH_B : integer := 8 
   ) ;       
  port
    (
	 i_a     : in std_logic_vector(WIDTH_A-1 downto 0);
	 i_b     : in std_logic_vector(WIDTH_B-1 downto 0) ;
	 o_out   : out std_logic_vector((WIDTH_A + WIDTH_B)-1 downto 0) 
	 );
  
 end component unsigned_multiplier  ;
 
 
  --- signal declaration 
  
  signal a_in  : std_logic_vector(WIDTH_A-1 downto 0) ;
  signal b_in  : std_logic_vector(WIDTH_B-1 downto 0) ;
  signal c_out : std_logic_vector((WIDTH_A + WIDTH_B)-1 downto 0) ;
  
  
  
  --- DUT 
  --- Design under Test_unsigned_multiplier
  begin
  
   UUT : unsigned_multiplier 
          generic map (WIDTH_A, WIDTH_B)
          port map (
			         i_a   => a_in , 
					   i_b   => b_in , 
					   o_out => c_out 
			        );
  
 test_proc : process 
  begin
    -- Stimulus 
	wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"7A67";
    b_in <= x"12";
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0A67";
    b_in <= x"22";
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0A07";
    b_in <= x"07";
    
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0007";
    b_in <= x"03";
    
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0017";
    b_in <= x"17";
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0067";
    b_in <= x"32";
    
    
    
     
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0027";
    b_in <= x"03";
    
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0037";
    b_in <= x"17";
    
    wait for 10 ns; -- Adjust this timing based on your design's requirements
    a_in <= x"0077";
    b_in <= x"32";
    
    
    wait for 130 ns;
    -- Additional stimulus if needed
    wait;
  end process test_proc;
			
	end Test_rtl ;
  