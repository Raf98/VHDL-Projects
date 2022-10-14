library verilog;
use verilog.vl_types.all;
entity Functional_vlg_check_tst is
    port(
        s               : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end Functional_vlg_check_tst;
