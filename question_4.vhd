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
    port ( LDA,LDB,S0,S1,CLK,RD : in std_logic;
            X,Y             : in std_logic_vector(7 downto 0);
                RA,RB       : inout std_logic_vector(7 downto 0));
                
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
    signal r2_result : std_logic_vector(7 downto 0);
    signal ld1:         std_logic;
    signal ld2:         std_logic;
    
begin
     m1:mux_2_1
        port map(A=>Y,
                B=>X,
                SEL=>S1,
                Y=>mux1_result);
                
     m2:mux_2_1
        port map(A=>Y,
                B=>RB,
                SEL=>S0,
                Y=>mux2_result);
         ld1<= LDA and RD;                           
    r1: res
        port map(input=>mux2_result,
                CLK=>CLK,
                ld=>ld1,
                output=>RA);
          ld2<=(LDB and (NOT RD));      
    r2: res
        port map(input=>mux1_result,
                CLK=>CLK,
                ld=>ld2,
                output=>RB);
                
end my_ckt;                                        
    
