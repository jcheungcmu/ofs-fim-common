	component fme_id_rom_2 is
		port (
			q       : out std_logic_vector(63 downto 0);                    -- dataout
			address : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			clock   : in  std_logic                     := 'X'              -- clk
		);
	end component fme_id_rom_2;

	u0 : component fme_id_rom_2
		port map (
			q       => CONNECTED_TO_q,       --       q.dataout
			address => CONNECTED_TO_address, -- address.address
			clock   => CONNECTED_TO_clock    --   clock.clk
		);

