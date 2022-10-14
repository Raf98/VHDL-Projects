library verilog;
use verilog.vl_types.all;
entity ULA_vlg_check_tst is
    port(
        display7        : in     vl_logic_vector(6 downto 0);
        display72       : in     vl_logic_vector(6 downto 0);
        VLED            : in     vl_logic;
        Z               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ULA_vlg_check_tst;
