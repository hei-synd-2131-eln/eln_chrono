ARCHITECTURE test OF coilControl_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';
  signal sEn: std_uLogic := '0';

BEGIN

  reset <= '1', '0' after clockPeriod/4;

  sClock <= not sClock after clockPeriod/2;
  clock <= sClock after clockPeriod/10;

  direction <= '1', '0' after 100*clockPeriod;

  sEn <= '1' after 3*clockPeriod when sEn = '0' else '0' after clockPeriod;
  en <= sEn;

END test;
