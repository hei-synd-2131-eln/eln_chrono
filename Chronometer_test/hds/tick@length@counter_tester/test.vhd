ARCHITECTURE test OF tickLengthCounter_tester IS

  constant clockPeriod: time := 50 ns;
  signal sClock: std_uLogic := '1';
  signal sClockDup: std_uLogic;
  signal sEnStep: std_uLogic := '0';
  signal sTickStep: std_uLogic := '0';

BEGIN

  reset <= '1', '0' after clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  sClockDup <= transport sClock after 9*clockPeriod/10;
  clock <= sClockDup;

  restart <= '1', '0' after 2*clockPeriod;

  sEnStep <= '1' after 3*clockPeriod when sEnStep = '0' else '0' after clockPeriod;
  enStep <= sEnStep;

  process(sEnStep, tickDone, sClockDup)
  begin
    if (tickDone = '1') and (sClockDup = '0') then
      sTickStep <= transport '0' after clockPeriod;
    elsif sEnStep = '1' then
      sTickStep <= transport '1' after 3*4*clockPeriod;
    end if;
  end process;

  tickStep <= sTickStep;

END test;
