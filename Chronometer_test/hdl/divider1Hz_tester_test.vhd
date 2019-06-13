ARCHITECTURE test OF divider1Hz_tester IS

  constant clockFrequency: real := 66.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  constant pulseWidth: time := 10 us;

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
    testMode <= '1';
    start    <= '0';

    wait for 15*clockPeriod;
    start <=  '1', '0' after clockPeriod;

    wait for 100*clockPeriod;
    testMode <= '0';

    wait;
  end process;

END ARCHITECTURE test;

