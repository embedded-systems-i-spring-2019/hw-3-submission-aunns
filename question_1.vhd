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
            CLK,lda: in std_logic;
               output: out std_logic_vector(7 downto 0));

end res;

architecture my_reg of res is 
begin
    process(CLK)
        begin
            if (rising_edge(CLK)) then
                if (lda='1') then
                     output<=input;
                end if;
            end if;
         end process    ;
end my_reg;
Library IEEE;
use IEEE.STD_Logic_1164.all;

entity ckt is 
    port ( LDA,SEL,CLK : in std_logic;
            D1,D2         : in std_logic_vector(7 downto 0);
                F       : out std_logic_vector(7 downto 0));
                
end ckt;

architecture my_ckt of ckt is
component res
        port(input : in std_logic_vector(7 downto 0);
            CLK,lda: in std_logic;
               output: out std_logic_vector(7 downto 0));
     end component;
 component mux_2_1 
     port( A,B : in std_logic_vector(7 downto 0);
            SEL: in std_logic;
               Y: out std_logic_vector(7 downto 0));
    end component;
    signal mux_result : std_logic_vector(7 downto 0);

begin
    
     
    ra:  res
    port map( input=>mux_result,
                CLK=>CLK,
                lda=>LDA,
                output=>F
                );
    m1: mux_2_1
    port map(     A=>D1,
                    B=>D2,
                    SEL=>SEL,
                    Y=>mux_result);
end my_ckt;                                                      
                    
          
                    
