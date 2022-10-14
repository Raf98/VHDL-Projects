library verilog;
use verilog.vl_types.all;
entity Contador3bits is
    port(
        clock           : in     vl_logic;
        hasLoad         : in     vl_logic;
        clear           : in     vl_logic;
        load            : in     vl_logic_vector(2 downto 0);
        Q               : out    vl_logic_vector(2 downto 0)
    );
end Contador3bits;
