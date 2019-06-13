ARCHITECTURE test OF coilControl_tester IS

  constant clockFrequency: real := 66.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  signal sEn: std_uLogic := '0';

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  ------------------------------------------------------------------------------
                                                                -- enable signal
  process
  begin
    sEn <= '0';
 
    for index in 1 to 3 loop
      wait until rising_edge(sClock);
    end loop;

    sEn <= '1';

    wait until rising_edge(sClock);

  end process;

  en <= sEn;

  ------------------------------------------------------------------------------
                                                                -- test sequence
  process
  begin
    direction <= '1';

    wait for 100*clockPeriod;
    direction <= '0';

    wait for 100*clockPeriod;
  end process;

END ARCHITECTURE test;

