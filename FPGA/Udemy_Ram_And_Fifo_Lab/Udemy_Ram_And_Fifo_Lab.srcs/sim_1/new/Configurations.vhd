configuration ip_ram_cfg of T_BlockRam is
  for Behavioral
    for DUT : FPGA_RAM
      use entity work.FPGA_RAM(ip_ram_arch);
    end for;
  end for;
end configuration;

configuration inferred_ram_cfg of T_BlockRam is
  for Behavioral
    for DUT : FPGA_RAM
      use entity work.FPGA_RAM(inferred_ram_arch);
    end for;
  end for;
end configuration;

