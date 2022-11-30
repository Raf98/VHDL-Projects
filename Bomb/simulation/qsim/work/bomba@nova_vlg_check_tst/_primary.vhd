library verilog;
use verilog.vl_types.all;
entity bombaNova_vlg_check_tst is
    port(
        desarmar        : in     vl_logic;
        displayAux      : in     vl_logic_vector(6 downto 0);
        displayCod      : in     vl_logic_vector(6 downto 0);
        displayMin1     : in     vl_logic_vector(6 downto 0);
        displayMin2     : in     vl_logic_vector(6 downto 0);
        displaySeg1     : in     vl_logic_vector(6 downto 0);
        displaySeg2     : in     vl_logic_vector(6 downto 0);
        explodiu        : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end bombaNova_vlg_check_tst;
