library verilog;
use verilog.vl_types.all;
entity FlipFlopJK is
    port(
        J               : in     vl_logic;
        K               : in     vl_logic;
        clock           : in     vl_logic;
        preset          : in     vl_logic;
        Q               : out    vl_logic;
        Q_NOT           : out    vl_logic
    );
end FlipFlopJK;
