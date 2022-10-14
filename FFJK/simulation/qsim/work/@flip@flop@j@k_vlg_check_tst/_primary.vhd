library verilog;
use verilog.vl_types.all;
entity FlipFlopJK_vlg_check_tst is
    port(
        Q               : in     vl_logic;
        Q_NOT           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end FlipFlopJK_vlg_check_tst;
