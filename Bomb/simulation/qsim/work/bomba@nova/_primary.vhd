library verilog;
use verilog.vl_types.all;
entity bombaNova is
    port(
        fios            : in     vl_logic_vector(4 downto 0);
        displaySeg1     : out    vl_logic_vector(6 downto 0);
        displaySeg2     : out    vl_logic_vector(6 downto 0);
        displayMin1     : out    vl_logic_vector(6 downto 0);
        displayMin2     : out    vl_logic_vector(6 downto 0);
        displayCod      : out    vl_logic_vector(6 downto 0);
        displayAux      : out    vl_logic_vector(6 downto 0);
        codEntrada      : in     vl_logic_vector(3 downto 0);
        setInDesarme    : in     vl_logic;
        setDesarme      : in     vl_logic;
        clock           : in     vl_logic;
        setCont         : in     vl_logic;
        selCont         : in     vl_logic_vector(1 downto 0);
        desarmar        : out    vl_logic;
        explodiu        : out    vl_logic;
        selOp           : in     vl_logic_vector(1 downto 0)
    );
end bombaNova;
