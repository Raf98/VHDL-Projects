library verilog;
use verilog.vl_types.all;
entity Registrador1bit is
    port(
        D               : in     vl_logic;
        clock           : in     vl_logic;
        clear           : in     vl_logic;
        load            : in     vl_logic;
        Q               : out    vl_logic
    );
end Registrador1bit;
