library verilog;
use verilog.vl_types.all;
entity Divisor is
    port(
        clock           : in     vl_logic;
        display         : out    vl_logic_vector(6 downto 0)
    );
end Divisor;
