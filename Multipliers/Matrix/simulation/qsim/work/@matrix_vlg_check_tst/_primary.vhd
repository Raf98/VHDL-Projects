library verilog;
use verilog.vl_types.all;
entity Matrix_vlg_check_tst is
    port(
        m               : in     vl_logic_vector(63 downto 0);
        sampler_rx      : in     vl_logic
    );
end Matrix_vlg_check_tst;
