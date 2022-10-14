library verilog;
use verilog.vl_types.all;
entity Contador4bits_vlg_check_tst is
    port(
        Q               : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end Contador4bits_vlg_check_tst;
