library verilog;
use verilog.vl_types.all;
entity FlipFlopJK_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        preset          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end FlipFlopJK_vlg_sample_tst;
