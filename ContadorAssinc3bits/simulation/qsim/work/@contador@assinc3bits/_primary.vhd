library verilog;
use verilog.vl_types.all;
entity ContadorAssinc3bits is
    port(
        clock           : in     vl_logic;
        Q               : out    vl_logic_vector(2 downto 0);
        Q_NOT           : out    vl_logic_vector(2 downto 0)
    );
end ContadorAssinc3bits;
