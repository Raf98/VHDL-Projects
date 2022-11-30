library verilog;
use verilog.vl_types.all;
entity bombaNova_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        codEntrada      : in     vl_logic_vector(3 downto 0);
        fios            : in     vl_logic_vector(4 downto 0);
        selCont         : in     vl_logic_vector(1 downto 0);
        selOp           : in     vl_logic_vector(1 downto 0);
        setCont         : in     vl_logic;
        setDesarme      : in     vl_logic;
        setInDesarme    : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end bombaNova_vlg_sample_tst;
