----------------------------------------------------------------------------------
-- Company: Bilkent University
-- Engineer: Can Gokay Kus
-- 
-- Create Date: 11/29/2020 09:54:59 PM
-- Design Name: 
-- Module Name: tictactoe - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tictactoe is
    Port ( clk : in std_logic;
           rst : in std_logic;
           hsync: out std_logic;
           vsync: out std_logic;
           RGB : out std_logic_vector( 2 downto 0);
           user1 : in STD_LOGIC_VECTOR (8 downto 0);
           user2o : out STD_LOGIC_VECTOR (8 downto 0));
end tictactoe;

architecture Behavioral of tictactoe is

signal clk25: std_logic := '0';
signal clk50: std_logic := '0';
signal hpos: integer := 0;
signal vpos: integer := 0;
signal vidon: std_logic := '0';
signal u1winS: std_logic;
signal u2winS: std_logic;
signal drawS: std_logic;
signal user1_p : std_logic_vector(8 downto 0);
signal user2 : std_logic_vector(8 downto 0) := "000000000";
signal charcount: std_logic_vector( 5 downto 0);
signal counter_l: std_logic_vector( 5 downto 0);
signal datax : std_logic_vector(63 downto 0);


constant HoD: integer := 639;
constant HFP: integer := 16;
constant HSP: integer := 96;
constant HBP: integer := 48;

constant VeD: integer := 479;
constant VFP: integer := 10;
constant VSP: integer := 2;
constant VBP: integer := 33;

--component romx
-- port (
--  address : in std_logic_vector(5 downto 0); 
--  data : out std_logic_vector(63 downto 0));
--end component;



--component AIAL
--    Port ( rst : in std_logic;
--           AIbut : in std_logic;
--           clk : in std_logic;
--           user1 : in STD_LOGIC_VECTOR (8 downto 0);
--           user2 : out STD_LOGIC_VECTOR (8 downto 0);
--           AIbut_2 : in std_logic);
           
--end component;


begin

--AImove: AIAL port map(
--    clk => clk25,
--    AIbut => AIbut,
--    rst => rst,
--    user1 => user1,
--    user2 => user2,
--    AIbut_2 => AIbut_2
--);

AI_move: process(user1,clk25)
begin
if rst = '1' then
    user2 <= "000000000";
else
    
    if rising_edge(clk25) then
        user1_p <= user1;
    if user1_p /= user1 and ((u1winS = '0') and (u2winS = '0')) then

    if ( user2(0)='0' AND user1(0)='0' ) AND (( user2(1)='1' AND user2(2)='1' ) OR ( user2(3)='1' AND user2(6)='1' ) OR ( user2(4)='1' AND user2(8)='1' )) then                 
        user2(0) <= '1';
    elsif ( ( user2(1)='0' AND user1(1)='0' ) AND (( user2(0)='1' AND user2(2)='1' ) OR ( user2(4)='1' AND user2(7)='1' )) ) then
        user2(1) <= '1';
    elsif (( user2(2)='0' AND user1(2)='0' ) AND (( user2(0)='1' AND user2(1)='1' ) OR ( user2(4)='1' AND user2(6)='1' ) OR ( user2(5)='1' AND user2(8)='1' )) ) then
        user2(2) <= '1';
    elsif ( ( user2(3)='0' AND user1(3)='0' ) AND (( user2(0)='1' AND user2(6)='1' ) OR ( user2(4)='1' AND user2(5)='1' )) ) then
        user2(3)<='1';
    elsif (( user2(4)='0' AND user1(4)='0' ) AND (( user2(0)='1' AND user2(8)='1' ) OR ( user2(2)='1' AND user2(6)='1' ) OR ( user2(1)='1' AND user2(7)='1' ) OR ( user2(3)='1' AND user2(5)='1' )) ) then
        user2(4)<='1';
    elsif ( ( user2(5)='0' AND user1(5)='0' ) AND (( user2(2)='1' AND user2(8)='1' ) OR ( user2(3)='1' AND user2(4)='1' )) ) then
        user2(5)<='1';
    elsif (( user2(6)='0' AND user1(6)='0' ) AND (( user2(0)='1' AND user2(3)='1' ) OR ( user2(2)='1' AND user2(4)='1' ) OR ( user2(7)='1' AND user2(8)='1' )) ) then
        user2(6)<='1';
    elsif ( ( user2(7)='0' AND user1(7)='0' ) AND (( user2(1)='1' AND user2(4)='1' ) OR ( user2(6)='1' AND user2(8)='1' )) ) then
        user2(7)<='1';
    elsif (( user2(8)='0' AND user1(8)='0' ) AND (( user2(0)='1' AND user2(4)='1' ) OR ( user2(2)='1' AND user2(5)='1' ) OR ( user2(6)='1' AND user2(7)='1' )) ) then
        user2(8)<='1';
    -- block user1 wins
    elsif ( ( user2(0)='0' AND user1(0)='0' ) AND (( user1(1)='1' AND user1(2)='1' ) OR ( user1(3)='1' AND user1(6)='1' ) OR ( user1(4)='1' AND user1(8)='1' )) ) then                
        user2(0)<='1';
    elsif ( ( user2(1)='0' AND user1(1)='0' ) AND (( user1(0)='1' AND user1(2)='1' ) OR ( user1(4)='1' AND user1(7)='1' )) ) then
        user2(1)<='1';
    elsif (( user2(2)='0' AND user1(2)='0' ) AND (( user1(0)='1' AND user1(1)='1' ) OR ( user1(4)='1' AND user1(6)='1' ) OR ( user1(5)='1' AND user1(8)='1' )) ) then
        user2(2)<='1';
    elsif ( ( user2(3)='0' AND user1(3)='0' ) AND (( user1(0)='1' AND user1(6)='1' ) OR ( user1(4)='1' AND user1(5)='1' )) ) then
        user2(3)<='1';
    elsif (( user2(4)='0' AND user1(4)='0' ) AND (( user1(0)='1' AND user1(8)='1' ) OR ( user1(2)='1' AND user1(6)='1' ) OR ( user1(1)='1' AND user1(7)='1' ) OR ( user1(3)='1' AND user1(5)='1' )) ) then
        user2(4)<='1';
    elsif ( ( user2(5)='0' AND user1(5)='0' ) AND (( user1(2)='1' AND user1(8)='1' ) OR ( user1(3)='1' AND user1(4)='1' )) ) then
        user2(5)<='1';
    elsif (( user2(6)='0' AND user1(6)='0' ) AND (( user1(0)='1' AND user1(3)='1' ) OR ( user1(2)='1' AND user1(4)='1' ) OR ( user1(7)='1' AND user1(8)='1' )) ) then
        user2(6)<='1';
    elsif ( ( user2(7)='0' AND user1(7)='0' ) AND (( user1(1)='1' AND user1(4)='1' ) OR ( user1(6)='1' AND user1(8)='1' )) ) then
        user2(7)<='1';
    elsif ( ( user2(8)='0' AND user1(8)='0' ) AND (( user1(0)='1' AND user1(4)='1' ) OR ( user1(2)='1' AND user1(5)='1' ) OR ( user1(6)='1' AND user1(7)='1' )) ) then
        user2(8)<='1';
     --p
    elsif ( user2(2)='0' AND user1(2)='0' ) then 
        user2(2) <= '1';
    elsif ( user2(0)='0' AND user1(0)='0' ) then                                                                                                                 
        user2(0) <= '1';
    elsif ( user2(6)='0' AND user1(6)='0' ) then 
        user2(6) <= '1'; 
    elsif ( user2(8)='0' AND user1(8)='0' ) then 
        user2(8) <= '1';
    elsif ( user2(4)='0' AND user1(4)='0' ) then 
        user2(4) <= '1';
    elsif ( user2(1)='0' AND user1(1)='0' ) then 
        user2(1) <= '1';
    elsif ( user2(3)='0' AND user1(3)='0' ) then 
        user2(3) <= '1';
    elsif ( user2(5)='0' AND user1(5)='0' ) then 
        user2(5) <= '1';
    elsif ( user2(7)='0' AND user1(7)='0' ) then 
        user2(7) <= '1';
    end if;
end if;
end if;
end if;
end process;




clock_divider_100to25: process(clk)

begin


    if rising_edge(clk) then
        clk50 <= not clk50;
    end if;
    
    
    if rising_edge(clk50) then
        clk25 <= not clk25;
    end if;
    
end process;


Ho_pos_count: process(clk25,rst)
begin
if rst = '1' then
    hpos <= 0;
elsif rising_edge(clk25) then
    if hpos = HoD + HFP + HSP + HBP then
        hpos <= 0;
    else
        hpos <= hpos + 1;
    end if;
end if;
end process;

Ve_pos_count: process(clk25,rst, hpos)
begin
if rst = '1' then
    vpos <= 0;
elsif rising_edge(clk25) then
  if hpos = HoD + HFP + HSP + HBP then
    if vpos = VeD + VFP + VSP + VBP then
        vpos <= 0;
    else
        vpos <= vpos + 1;
    end if;
  end if;
end if;
end process;

 p0: process (clk25,rst)
     begin 
          
         if rst = '1' then

      charcount <= (others => '0');
    elsif rising_edge(clk25) then
      --    if(rst = '1') then 
      --     counter_p <= "000000";
      --    else
      
          if(hpos = 81) then
            counter_l <= "000000";
          elsif(hpos = 246) then
            counter_l <= "000000";
          elsif(hpos = 411) then
            counter_l <= "000000";
          elsif(hpos = 48) then  
            counter_l <= "000000";
			else
			   counter_l <= counter_l+1;
      --    end if; 
         end if;
          if(vpos = 212) then
            charcount <= "000000";
          elsif(vpos = 432) then
            charcount <= "000000";
          elsif(vpos = 652) then
            charcount <= "000000";
          elsif(vpos = 64) then  
            charcount <= "000000";
			 else
			   charcount <= charcount+1;
          end if; 
      --   end if; 
        end if;       
           
  end process;







HoSy : process(clk25, rst, hpos)
begin
if rst = '1' then
    hsync <= '0';
elsif rising_edge(clk25) then
    if (hpos <= HoD + HFP) or (hpos > HoD +HFP +HSP) then
        hsync <= '1';
    else
        hsync <= '0';
    end if;
end if;
end process;

VeSy : process(clk25, rst, vpos)
begin
if rst = '1' then
    vsync <= '0';
elsif rising_edge(clk25) then
    if (vpos <= veD + vFP) or (vpos > veD +vFP +vSP) then
        vsync <= '1';
    else
        vsync <= '0';
    end if;
end if;
end process;


viddon: process(clk25, rst, hpos,vpos)
begin
if rst = '1' then
    vidon <= '0';
elsif rising_edge(clk25) then
    if (hpos <= HoD AND Vpos <= VeD) then
        vidon <= '1';
    else
        vidon <= '0';
    end if;
end if;
end process;

grid_and_char: process(clk25,rst,hpos,vpos,vidon)
begin
if rst = '1' then
    RGB <= "000";
elsif rising_edge(clk25) then
    if Vidon = '1' then
        if ((vpos >= 155 and vpos <= 165) and (hpos >= 80 and hpos <= 560)) or ((vpos >= 315 and vpos <= 325)and (hpos >= 80 and hpos <= 560)) then
            if u1winS = '1' then
                RGB <= "100"; --blue
            elsif u2wins = '1' then
                RGB <= "001"; --red
            elsif user1 + user2 = "111111111" and u1winS = '0' and u2winS = '0' then
                RGB <= "011";
            else
                RGB <= "111";
            end if;
        elsif (hpos >= 235 and hpos <= 245) or (hpos >= 395 and hpos <= 405) then
            if u1winS = '1' then
                RGB <= "100"; --blue
            elsif u2wins = '1' then
                RGB <= "001"; --red
            elsif user1 + user2 = "111111111" and u1winS = '0' and u2winS = '0' then
                RGB <= "011";
            else
                RGB <= "111";
            end if;
        
        --012
        elsif (hpos >= 137 and hpos <= 177) and (vpos >= 55 and vpos <= 95) then
            if user1(0) = '1' then
                RGB <= "100"; --blue
            elsif user2(0) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 299 and hpos <= 339) and (vpos >= 55 and vpos <= 95) then
            if user1(1) = '1' then
                RGB <= "100"; --blue
            elsif user2(1) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 462 and hpos <= 502) and (vpos >= 55 and vpos <= 95) then
            if user1(2) = '1' then
                RGB <= "100"; --blue
            elsif user2(2) = '1' then
                RGB <= "001"; --red
            end if;
            
        --345  
        elsif (hpos >= 137 and hpos <= 177) and (vpos >= 220 and vpos <= 260) then
            if user1(3) = '1' then
                RGB <= "100"; --blue
            elsif user2(3) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 299 and hpos <= 339) and (vpos >= 220 and vpos <= 260) then
            if user1(4) = '1' then
                RGB <= "100"; --blue
            elsif user2(4) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 462 and hpos <= 502) and (vpos >= 220 and vpos <= 260) then
            if user1(5) = '1' then
                RGB <= "100"; --blue
            elsif user2(5) = '1' then
                RGB <= "001"; --red
            end if;
            
        --678
        elsif (hpos >= 137 and hpos <= 177) and (vpos >= 385 and vpos <= 425) then
            if user1(6) = '1' then
                RGB <= "100"; --blue
            elsif user2(6) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 299 and hpos <= 339) and (vpos >= 385 and vpos <= 425) then
            if user1(7) = '1' then
                RGB <= "100"; --blue
            elsif user2(7) = '1' then
                RGB <= "001"; --red
            end if;
        elsif (hpos >= 462 and hpos <= 502) and (vpos >= 385 and vpos <= 425) then
            if user1(8) = '1' then
                RGB <= "100"; --blue
            elsif user2(8) = '1' then
                RGB <= "001"; --red
            end if;        
                    
        else
            RGB <= "000";
        end if;
        end if;
end if;
end process;



-- (hpos >= 203 and hpos <= 223) or (hpos >= 416 and hpos <= 436) or 

user2o <= user2;


u1winS <= ( user1(8) and user1(7) and user1(6)) 
or ( user1(5) and user1(4) and user1(3))
or ( user1(2) and user1(1) and user1(0))
or ( user1(8) and user1(5) and user1(2))
or ( user1(7) and user1(4) and user1(1))
or ( user1(6) and user1(3) and user1(0))
or ( user1(8) and user1(4) and user1(0))
or ( user1(2) and user1(4) and user1(6));

u2winS <= ( user2(8) and user2(7) and user2(6)) 
or ( user2(5) and user2(4) and user2(3))
or ( user2(2) and user2(1) and user2(0))
or ( user2(8) and user2(5) and user2(2))
or ( user2(7) and user2(4) and user2(1))
or ( user2(6) and user2(3) and user2(0))
or ( user2(8) and user2(4) and user2(0))
or ( user2(2) and user2(4) and user2(6));


user2o <= user2;

end Behavioral;
