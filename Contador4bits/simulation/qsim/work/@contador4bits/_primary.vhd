library verilog;
use verilog.vl_types.all;
entity Contador4bits is
    port(
        clock           : in     vl_logic;
        Q               : out    vl_logic_vector(3 downto 0)
    );
end Contador4bits;
