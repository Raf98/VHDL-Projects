library verilog;
use verilog.vl_types.all;
entity FlipFlopD is
    port(
        D               : in     vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        Q               : out    vl_logic;
        Q_NOT           : out    vl_logic
    );
end FlipFlopD;
