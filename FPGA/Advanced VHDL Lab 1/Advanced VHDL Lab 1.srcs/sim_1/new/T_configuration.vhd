configuration ip_ram_cfg of T_dp_mem is
  for Behavioral
    for DUT : dp_mem
      use entity work.dp_mem(dp_mem_a);
    end for;
  end for;
end configuration;

configuration inferred_ram_cfg of T_dp_mem is
  for Behavioral
    for DUT : dp_mem
      use entity work.dp_mem(dp_mem_inferred_a);
    end for;
  end for;
end configuration;

