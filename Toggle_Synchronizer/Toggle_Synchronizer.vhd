------------------------------------------------------------------------------
--- DESIGN : Toggle_Synchronizer
------------------------------------------------------------------------------


library IEEE                    ;
use IEEE.std_logic_1164.all     ;
use IEEE.std_logic_unsigned.all ;


------------------------------------------
-- entity declaration
------------------------------------------


entity Toggle_Synchronizer is 
port 
     (
	  i_clk_src  : in  std_logic ;
	  i_clk_dest : in  std_logic ;
	  i_rst      : in  std_logic ;
	  i_din      : in  std_logic ;
	  o_pulse    : out std_logic 
	 );
end entity Toggle_Synchronizer   ;



------------------------------------------
-- architecture definition
------------------------------------------

architecture behav_rtl of Toggle_Synchronizer is 

-- component declaration

  component mux_logic is 
 port 
     (
       in_1   : in std_logic ;
	   in_2   : in std_logic ;
       sel_in : in std_logic ;
       out_m  : out std_logic 
     ) ;

  end component mux_logic  ;  



-- constant declaration
constant FF_STAGES : integer := 3 ;

-- signal declaration

signal d_ff_1   : std_logic := '0'                                          ;
signal not_gate : std_logic := '0'                                          ;
signal xor_gate : std_logic := '0'                                          ;
signal mux_out  : std_logic := '0'                                          ;
								                                            
signal d_ff_2   : std_logic_vector(FF_STAGES-1 downto 0) := (others => '0') ;




------------------------------------------------------------------------
-- The following represents the initial value of synchronizer register
-- it is `1` incase there is active low(0) reset
-- and `0` incase if there is active high(1) reset
------------------------------------------------------------------------
 
signal INIT_VAL          : std_logic := '0'                                  ; 
------------------------------------------------------------------------
-- sync_reset_reg 
------------------------------------------------------------------------
signal reset_reg : std_logic_vector (FF_STAGES-1 downto 0)                   ;
signal sync_reset: std_logic    := '0'                                       ;

------------------------------------------------------------------------
-- Async_reg attribute 
------------------------------------------------------------------------
attribute async_reg : string                                                 ;
attribute Async_reg of reset_reg : signal is "true"                          ;
------------------------------------------------------------------------
--- begin architecture 
------------------------------------------------------------------------

begin

------------------------------------------
-- SYNC_RST_REG
------------------------------------------

sync_reset   <= reset_reg(FF_STAGES-1)                                       ;

--- async_reset register 

SYNC_RST_REG  : process (i_clk_src , i_rst)
begin
            if (rising_edge(i_clk_src)) then 
			   if (i_rst = '1') then 
			       reset_reg <= (others => '1')                              ;
			   else
			       reset_reg <= reset_reg(FF_STAGES-2 downto 0) & INIT_VAL   ;
			   end if                                                        ;
          end if                                                             ;
end process SYNC_RST_REG                                                     ;

------------------------
--- register source_clk
------------------------

rtl_proc_src_clk : process (i_clk_src)
    begin 
	             if (rising_edge(i_clk_src)) then 
				     if (sync_reset = '1') then
                         d_ff_1 <= '0'                                        ;
                     else                                                     
                         d_ff_1 <= mux_out                                    ;
                     end if                                                   ; 
                 end if                                                       ;
end process rtl_proc_src_clk                                                  ;				 
					 
----------------------
-- Mux logic 
----------------------

-- not gate
not_gate <= not(d_ff_1)                                                       ;


--------------------
-- Mux
--------------------

UU_MUX: mux_logic 
 port map 
     (
       in_1   => d_ff_1 , 
	   in_2   => not_gate, 
       sel_in => i_din, 
       out_m  => mux_out 
     ) ;


----------------------------
-- register stages dest clk
----------------------------

rtl_proc_dest_clk : process (i_clk_dest)
begin
       if (rising_edge(i_clk_dest)) then 
	     if (sync_reset = '1') then 
		     d_ff_2 <= (others => '0')                                      ;
		 else 
		     d_ff_2 <= d_ff_2(FF_STAGES-2 downto 0 ) & d_ff_1               ;                        
		    -- d_ff_2(FF_STAGES
		 end if                                                             ;
	   end if                                                                   ;
end process rtl_proc_dest_clk                                                       ;


----------------------------
-- xor logic 
----------------------------

xor_gate <= d_ff_2(FF_STAGES-1) xor d_ff_2(FF_STAGES-2)                     ;

----------------------------
-- pulse gen 
----------------------------
o_pulse <= xor_gate                                                         ;


---------------------------
-- end architecture
---------------------------


end architecture behav_rtl                                                  ;         





