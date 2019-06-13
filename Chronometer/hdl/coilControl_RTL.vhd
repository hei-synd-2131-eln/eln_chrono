ARCHITECTURE RTL OF coilControl IS

  signal pwmCounter: unsigned(amplitude'range);
  signal enAmplitude: std_ulogic;
  signal phase: unsigned(1 downto 0);

BEGIN
  ------------------------------------------------------------------------------
                                                         -- output amplitude PWM
  buildTriangle: process(reset, clock)
  begin
    if reset = '1' then
      pwmCounter <= (others => '0');
    elsif rising_edge(clock) then
      if enPwm = '1' then
        pwmCounter <= pwmCounter + 1;
      end if;
    end if;
  end process buildTriangle;

  enAmplitude <= '1' when amplitude >= pwmCounter
    else '0';

  ------------------------------------------------------------------------------
                                                                -- phase counter
  countPhases: process(reset, clock)
  begin
    if reset = '1' then
      phase <= (others => '0');
    elsif rising_edge(clock) then
      if enStep = '1' then
        if direction = '1' then
          phase <= phase + 1;
        else
          phase <= phase - 1;
        end if;
      end if;
    end if;
  end process countPhases;

  ------------------------------------------------------------------------------
                                                                -- phase pattern
  buildPhases: process(phase, enAmplitude)
  begin
    coil1 <= '0';
    coil2 <= '0';
    coil3 <= '0';
    coil4 <= '0';
    case to_integer(phase) is
-- wave drive
      when 1 => coil1 <= enAmplitude;
      when 2 => coil2 <= enAmplitude;
      when 3 => coil3 <= enAmplitude;
      when 0 => coil4 <= enAmplitude;
-- full step drive
--      when 1 => coil1 <= enAmplitude; coil2 <= enAmplitude;
--      when 2 => coil2 <= enAmplitude; coil3 <= enAmplitude;
--      when 3 => coil3 <= enAmplitude; coil4 <= enAmplitude;
--      when 0 => coil4 <= enAmplitude; coil1 <= enAmplitude;
      when others => null;
    end case;
  end process buildPhases;

END ARCHITECTURE RTL;
