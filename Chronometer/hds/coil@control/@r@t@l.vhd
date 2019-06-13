ARCHITECTURE RTL OF coilControl IS
  signal step: unsigned(1 downto 0);
BEGIN

  count: process(reset, clock)
  begin
    if reset = '1' then
      step <= (others => '0');
    elsif rising_edge(clock) then
      if en = '1' then
        if direction = '1' then
          step <= step + 1;
        else
          step <= step - 1;
        end if;
      end if;
    end if;
  end process count;

  buildPhases: process(step)
  begin
    coil1 <= '0';
    coil2 <= '0';
    coil3 <= '0';
    coil4 <= '0';
    case to_integer(step) is
      when 1 => coil1 <= '1';
      when 2 => coil2 <= '1';
      when 3 => coil3 <= '1';
      when 0 => coil4 <= '1';
      when others => null;
    end case;
  end process buildPhases;

END RTL;
