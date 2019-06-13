library Common;
  use Common.CommonLib.all;

ARCHITECTURE RTL OF divider1Hz IS

  signal pwmCounter: unsigned(requiredBitNb(pwmDivide-1)-1 downto 0);
  signal pwmCounterEnd: std_ulogic;
  signal stepCounter: unsigned(requiredBitNb(stepDivide-1)-1 downto 0);
  signal stepCounterEnd: std_ulogic;
  signal counter1Hz: unsigned(requiredBitNb(stepTo1HzDivide-1)-1 downto 0);
  signal counter1HzEnd: std_ulogic;

BEGIN
  ------------------------------------------------------------------------------
                                                           -- PWM enable counter
  countPwm: process(reset, clock)
  begin
    if reset = '1' then
      pwmCounter <= (others => '0');
    elsif rising_edge(clock) then
      if pwmCounterEnd = '0' then
        pwmCounter <= pwmCounter + 1;
      else
        pwmCounter <= (others => '0');
      end if;
    end if;
  end process countPwm;

  findPwmEnd: process(testmode, pwmCounter)
  begin
    pwmCounterEnd <= '0';
    if testMode = '0' then
      if pwmCounter >= pwmDivide-1 then
        pwmCounterEnd <= '1';
      end if;
    else
      pwmCounterEnd <= '1';
    end if;
  end process findPwmEnd;

  enPwm <= pwmCounterEnd;

  ------------------------------------------------------------------------------
                                                          -- step enable counter
  countStep: process(reset, clock)
  begin
    if reset = '1' then
      stepCounter <= (others => '0');
    elsif rising_edge(clock) then
      if start = '1' then
        stepCounter <= (others => '0');
      elsif stepCounterEnd = '0' then
        stepCounter <= stepCounter + 1;
      else
        stepCounter <= (others => '0');
      end if;
    end if;
  end process countStep;

  findStepEnd: process(testmode, stepCounter)
  begin
    stepCounterEnd <= '0';
    if testMode = '0' then
      if stepCounter >= stepDivide-1 then
        stepCounterEnd <= '1';
      end if;
    else
      if stepCounter >= 15 then
        stepCounterEnd <= '1';
      end if;
    end if;
  end process findStepEnd;

  enStep <= stepCounterEnd;

  ------------------------------------------------------------------------------
                                                                 -- 1 Hz counter
  count1Hz: process(reset, clock)
  begin
    if reset = '1' then
      counter1Hz <= (others => '0');
    elsif rising_edge(clock) then
      if start = '1' then
        counter1Hz <= (others => '0');
      elsif stepCounterEnd = '1' then
        if counter1HzEnd = '0' then
          counter1Hz <= counter1Hz + 1;
        else
          counter1Hz <= (others => '0');
        end if;
      end if;
    end if;
  end process count1Hz;

  findEnd1Hz: process(counter1Hz)
  begin
    if counter1Hz = stepTo1HzDivide-1 then
      counter1HzEnd <= '1';
    else
      counter1HzEnd <= '0';
    end if;
  end process findEnd1Hz;

  build1Hz: process(counter1Hz, stepCounterEnd)
  begin
    if counter1Hz = 0 then
      en1Hz <= stepCounterEnd;
    else
      en1Hz <= '0';
    end if;
  end process build1Hz;

END ARCHITECTURE RTL;
