library verilog;
use verilog.vl_types.all;
entity ULA is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        F               : in     vl_logic_vector(2 downto 0);
        Z               : out    vl_logic;
        VLED            : out    vl_logic;
        display7        : out    vl_logic_vector(6 downto 0);
        display72       : out    vl_logic_vector(6 downto 0)
    );
end ULA;
