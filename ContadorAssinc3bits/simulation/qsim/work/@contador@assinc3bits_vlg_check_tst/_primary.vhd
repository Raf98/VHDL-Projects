library verilog;
use verilog.vl_types.all;
entity ContadorAssinc3bits_vlg_check_tst is
    port(
        Q               : in     vl_logic_vector(2 downto 0);
        Q_NOT           : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end ContadorAssinc3bits_vlg_check_tst;
