------------------------------------------------------------------------------
--- DESIGN : Pulse Stretcher
------------------------------------------------------------------------------


library IEEE ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all ;


------------------------------------------
-- entity declaration
------------------------------------------

entity Pulse_Stretcher is 
generic (
           SYNC_STAGES : integer := 3
		);
port 
       (
	     i_clk_src  : in  std_logic ;
		 i_clk_dest : in  std_logic ;
		 i_rst      : in  std_logic ;
		 i_din      : in  std_logic ;
		 o_pulse    : out std_logic 
	   );
end entity Pulse_Stretcher ;



------------------------------------------
-- architecture definition
------------------------------------------

architecture behav_rtl of Pulse_Stretcher is

-- signal declaration 

signal PIP_D_REG   : std_logic_vector(SYNC_STAGES -1 downto 0) := (others => '0') ;
signal OR_GATE_1   : std_logic := '0'                                              ;
signal OR_GATE_2   : std_logic := '0'                                              ;
signal LATCH_PULSE : std_logic := '0'                                              ;
signal pulse_en    : std_logic := '0'                                              ;
------------------------------------------------------------------------
-- The following represents the initial value of synchronizer register
-- it is `1` incase there is active low(0) reset
-- and `0` incase if there is active high(1) reset
------------------------------------------------------------------------
 
signal INIT_VAL          : std_logic := '0'                                        ; 
------------------------------------------------------------------------
-- sync_reset_reg 
------------------------------------------------------------------------
signal reset_reg : std_logic_vector (SYNC_STAGES-1 downto 0)                       ;
signal sync_reset: std_logic    := '0'                                             ;

------------------------------------------------------------------------
-- Async_reg attribute 
------------------------------------------------------------------------
attribute async_reg : string                                                       ;
attribute Async_reg of reset_reg : signal is "true"                                ;
------------------------------------------------------------------------
--- begin architecture 
------------------------------------------------------------------------

begin

------------------------------------------
-- SYNC_RST_REG
------------------------------------------

SYNC_RST_REG  : process (i_clk_src , i_rst)
begin
            if (rising_edge(i_clk_src)) then 
			   if (i_rst = '1') then 
			       reset_reg <= (others => '1')                              ;
			   else
			       reset_reg <= reset_reg(SYNC_STAGES-2 downto 0) & INIT_VAL ;
			   end if                                                        ;
          end if                                                             ;
end process SYNC_RST_REG                                                     ;

------------------------------------------
-- rtl pipeline registers
------------------------------------------

rtl_proc_pipline : process (i_clk_src, sync_reset) 
    begin
		    if (rising_edge(i_clk_src)) then 
		        if (sync_reset = '1') then 
			       PIP_D_REG <= (others => '0')                                ;
			    else                                                           
                  PIP_D_REG  <= PIP_D_REG(SYNC_STAGES-2 downto 0) &  i_din    ;
			    end if                                                         ;
		    end if                                                             ;
end process rtl_proc_pipline                                                   ;
		
-----------------------------------------
-- OR_GATE_1
-----------------------------------------

OR_GATE_1  <= PIP_D_REG(SYNC_STAGES-3) or i_din                                ;

-----------------------------------------
-- OR_GATE_2
-----------------------------------------
		
OR_GATE_2  <= PIP_D_REG(SYNC_STAGES-1) or PIP_D_REG(SYNC_STAGES-2) or 
                OR_GATE_1 ;	


-----------------------------------------
-- PULSE OUT SIGNAL 
-----------------------------------------

o_pulse <=  LATCH_PULSE                                                        ;
pulse_en <= OR_GATE_2                                                         ;

-----------------------------------------
-- SYNC_RESET 
-----------------------------------------

sync_reset <= reset_reg(SYNC_STAGES-1)                                         ;

----------------------------------------
-- REG RTL 
----------------------------------------
proc_rtl_pulse : process (i_clk_dest)
 begin
             if (rising_edge(i_clk_dest)) then
               if (sync_reset = '1') then 
                  LATCH_PULSE <= '0'                                           ;
               elsif (pulse_en = '1') then  
			       LATCH_PULSE <= '1'                                             ;
			      else
			        LATCH_PULSE <= '0'                                            ;
             end if                                                            ;
           end if                                                              ;
end process proc_rtl_pulse                                                     ;			 
----------------------------------------
-- END architecture 
----------------------------------------

end architecture behav_rtl                                                     ;

		 