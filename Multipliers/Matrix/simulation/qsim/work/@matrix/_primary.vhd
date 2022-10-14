library verilog;
use verilog.vl_types.all;
entity Matrix is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        m               : out    vl_logic_vector(63 downto 0)
    );
end Matrix;
