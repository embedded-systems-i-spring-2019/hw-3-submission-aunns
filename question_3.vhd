Library IEEE;
use IEEE.STD_Logic_1164.all;

entity mux_2_1 is
    port( A,B : in std_logic_vector(7 downto 0);
            SEL: in std_logic;
               Y: out std_logic_vector(7 downto 0));
end mux_2_1;
architecture my_mux of mux_2_1 is
begin
    with SEL select
        Y<=B when '1',
         A when '0',
        (others=> '0') when others;
end my_mux;

Library IEEE;
use IEEE.STD_Logic_1164.all;

entity res is
    port( input : in std_logic_vector(7 downto 0);
            CLK,ld: in std_logic;
               output: out std_logic_vector(7 downto 0));

end res;

architecture my_reg of res is 
begin
    process(CLK)
        begin
            if (rising_edge(CLK)) then
                if (ld='1') then
                     output<=input;
                end if;
            end if;
         end process    ;
end my_reg;

Library IEEE;
use IEEE.STD_Logic_1164.all;

entity ckt is 
    port ( LDA,LDB,S0,S1,CLK : in std_logic;
            X,Y             : in std_logic_vector(7 downto 0);
                RB       : inout std_logic_vector(7 downto 0));
                
end ckt;

architecture my_ckt of ckt is
component res
        port(input : in std_logic_vector(7 downto 0);
            CLK,ld: in std_logic;
               output: inout std_logic_vector(7 downto 0));
     end component;
 component mux_2_1 
     port( A,B : in std_logic_vector(7 downto 0);
            SEL: in std_logic;
               Y: out std_logic_vector(7 downto 0));
    end component;
    signal mux1_result : std_logic_vector(7 downto 0);
    signal mux2_result : std_logic_vector(7 downto 0);
    signal r1_result : std_logic_vector(7 downto 0);
    
begin
    m1:mux_2_1
        port map(A=>RB,
                B=>X,
                SEL=>S1,
                Y=>mux1_result);
    r1: res
        port map(input=>mux1_result,
                CLK=>CLK,
                ld=>LDA,
                output=>r1_result);
    m2:mux_2_1
        port map(A=>Y,
                B=>r1_result,
                SEL=>S0,
                Y=>mux2_result);                                 
                
    r2: res
        port map(input=>mux2_result,
                CLK=>CLK,
                ld=>LDB,
                output=>RB);
end my_ckt;                   
    
 