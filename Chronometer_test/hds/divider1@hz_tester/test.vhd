ARCHITECTURE test OF divider1Hz_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';

BEGIN

  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;

  testMode <= '1', '0' after 10000*clockPeriod;

  start <=  '0',
              '1' after 3*clockPeriod,
              '0' after 4*clockPeriod;

END test;
