ARCHITECTURE test OF chronometer_tester IS

  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  constant testModePulseWidth: time := 10 us;
  constant pulseWidth: time := 20 ms;

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                -- test sequence
  process
  begin
    ----------------------------------------------------------------------------
                                                                    -- test mode
    testMode <= '1';
    restart  <= '0';
    sensor   <= '0';
    start    <= '0';
    stop     <= '0';

    wait for 10 us;
    restart <=  '1', '0' after testModePulseWidth;

    wait for 40 us;
    sensor <= '1', '0' after testModePulseWidth;

    wait for 50 us;
    start <= '1', '0' after testModePulseWidth;

    wait for 300 us;
    stop <= '1', '0' after testModePulseWidth;

    ----------------------------------------------------------------------------
                                                                   -- real speed
    testMode <= '0';
    wait for 1 ms - now;
    restart <=  '1', '0' after pulseWidth;

    wait for 70 ms - now;
    sensor <= '1', '0' after pulseWidth;

    wait for 100 ms - now;
    start <=  '1', '0' after pulseWidth;

    wait;
  end process;

END ARCHITECTURE test;
