
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

entity decoder is 
    port( A :in std_logic;
          
          Y:out std_logic_vector(1 downto 0));
end decoder;

architecture my_decoder of decoder is
begin
    with A select
        Y<="01" when '0',
            "10" when '1',
        "0" when others;
end my_decoder;    

Library IEEE;
use IEEE.STD_Logic_1164.all;

entity ckt is 
    port ( SL1,SL2,CLK : in std_logic;
            A,B,C           : in std_logic_vector(7 downto 0);
                RAX,RBX       : inout std_logic_vector(7 downto 0));
                
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
    
component decoder
    port( A :in std_logic;
          
          Y:out std_logic_vector(1 downto 0));
    end component;          
    
     signal d1_result: std_logic_vector (1 downto 0);
    signal m1_result:   std_logic_vector(7 downto 0);
    
       
begin
    m1:mux_2_1
        port map(A=>C,
                B=>B,
                SEL=>SL2,
                Y=>m1_result);
                
    r1: res
        port map(input=>A,
                CLK=>CLK,
                ld=>d1_result(1),
                output=>RAX);
        
          
    r2: res
        port map(input=>m1_result,
                CLK=>CLK,
                ld=>d1_result(0),
                output=>RBX);
                      
          
    dec1: decoder
        port map(A=>SL1,
                    Y(0)=> d1_result(0),
                    Y(1)=>d1_result(1));    
                    
end my_ckt;                                        
   