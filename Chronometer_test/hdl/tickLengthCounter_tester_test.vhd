ARCHITECTURE test OF tickLengthCounter_tester IS

  constant clockFrequency: real := 66.0E6;
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';

  signal sEn: std_uLogic := '0';
  signal sTickStep: std_uLogic := '0';

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

  enStep <= sEn;

  ------------------------------------------------------------------------------
                                              -- tick step: stops after tickDone
  process(sEn, tickDone, sClock)
  begin
    if (tickDone = '1') and (sClock = '0') then
      sTickStep <= transport '0' after clockPeriod;
    elsif sEn = '1' then
      sTickStep <= transport '1' after 3*4*clockPeriod;
    end if;
  end process;

  tickStep <= sTickStep;

  ------------------------------------------------------------------------------
                                                                -- test sequence
  process
  begin
    restart<= '0';

    wait for 20*clockPeriod;
    restart <=  '1', '0' after clockPeriod;

    wait;
  end process;

END ARCHITECTURE test;

