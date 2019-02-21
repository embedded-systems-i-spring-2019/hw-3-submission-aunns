Library IEEE;
use IEEE.STD_Logic_1164.all;

entity mux_4_1 is
    port( A,B,C,D : in std_logic_vector(7 downto 0);
            SEL: in std_logic_vector(1 downto 0);
               Y: out std_logic_vector(7 downto 0));
end mux_4_1;
architecture my_mux of mux_4_1 is
begin
    with SEL select
        Y<=A when "00",
         B when "01",
         C when "10",
         D when "11",
        (others=> '0') when others;
end my_mux;
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
    port ( DS,CLK : in std_logic;
            SEL: in std_logic_vector(1 downto 0);
            D1,D2,D3         : in std_logic_vector(7 downto 0);
                RA,RB       : inout std_logic_vector(7 downto 0));
                
end ckt;

architecture my_ckt of ckt is
component decoder
    port( A :in std_logic;
          
          Y:out std_logic_vector(1 downto 0));
end component;          
component res
        port(input : in std_logic_vector(7 downto 0);
            CLK,ld: in std_logic;
               output: inout std_logic_vector(7 downto 0));
     end component;
 component mux_4_1 
port( A,B,C,D : in std_logic_vector(7 downto 0);
            SEL: in std_logic_vector(1 downto 0);
               Y: out std_logic_vector(7 downto 0));
    end component;
    signal mux_result : std_logic_vector(7 downto 0);
    signal lda: std_logic;
    signal ldb: std_logic;
    signal raout: std_logic_vector(7 downto 0);

begin
    dec: decoder
    port map( A=>DS,
                Y(0)=>lda,
                Y(1)=>ldb);
     
    r1:  res
    port map( input=>mux_result,
                CLK=>CLK,
                ld=>lda,
                output=>RA
                );
                
    r2:  res
    port map( input=>RA,
                CLK=>CLK,
                ld=>ldb,
                output=>RB
                );                
    m1: mux_4_1
    port map(     A=>RB,
                    B=>D1,
                    C=>D2,
                    D=>D3,
                    SEL=>SEL,
                    Y=>mux_result);
end my_ckt;                                                      
                    
          
                    
