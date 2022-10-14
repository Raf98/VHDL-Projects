library verilog;
use verilog.vl_types.all;
entity Contador3bits_vlg_sample_tst is
    port(
        clear           : in     vl_logic;
        clock           : in     vl_logic;
        hasLoad         : in     vl_logic;
        load            : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end Contador3bits_vlg_sample_tst;
