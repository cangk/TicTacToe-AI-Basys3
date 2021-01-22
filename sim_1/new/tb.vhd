----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2020 10:08:50 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
component tictactoe
    Port ( clk : in std_logic;
           rst : in std_logic;
           hsync: out std_logic;
           vsync: out std_logic;
           RGB : out std_logic_vector( 2 downto 0);
           user1 : in STD_LOGIC_VECTOR (8 downto 0);
           AIbut: in std_logic;
           AIbut_2: in std_logic;
           user2o : out STD_LOGIC_VECTOR (8 downto 0);
           u1win : out STD_LOGIC;
           u2win : out STD_LOGIC;
           draw : out STD_LOGIC);
end component;
signal clk : std_logic := '0';
signal rst : std_logic := '0';
signal vsync : std_logic;
signal hsync : std_logic;
signal RGB : std_logic_vector(2 downto 0);
signal user1 : std_logic_vector(8 downto 0) := "000000000";
signal AIbut : std_logic := '0';
signal user2o : std_logic_vector(8 downto 0);
signal AIbut_2 : std_logic := '0';
signal u1win : std_logic;
signal u2win : std_logic;
signal draw : std_logic;

constant clk_period:time := 0.5 ns;

begin

uut: tictactoe port map(
    clk => clk,
    rst => rst,
    hsync => hsync,
    vsync => vsync,
    RGB => RGB,
    user2o => user2o,
    user1 => user1,
    AIbut => AIbut,
    u1win => u1win,
    u2win => u2win,
    draw => draw,
    AIbut_2 => AIbut_2
);

clock_process: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim_proc: process
begin

    user1 <= "000000000";
    wait for 10 ns;

    wait for 10 ns;

    wait for 10 ns;
    user1 <= "000000001";
    wait for 10 ns;

    wait for 10 ns;

    wait for 10 ns;
    user1 <= "000001000";
    wait for 10 ns;
    AIbut <= '1';
    wait for 10 ns;
    AIbut <= '0';
    wait for 10 ns;
--    user1 <= "010000001";
    
    wait;
    
end process;

end Behavioral;
