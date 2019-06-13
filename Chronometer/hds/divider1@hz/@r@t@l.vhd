ARCHITECTURE RTL OF divider1Hz IS
  signal counter1: unsigned(17 downto 0);
  signal counter2: unsigned(6 downto 0);
  signal counter1IsZero: std_ulogic;
BEGIN

  count1: process(reset, clock)
  begin
    if reset = '1' then
      counter1 <= (others => '0');
    elsif rising_edge(clock) then
      if start = '1' then
        counter1 <= (others => '0');
      elsif testmode = '0' then
        if counter1 < (156250-1) then
          counter1 <= counter1 + 1;
        else
          counter1 <= (others => '0');
        end if;
      else
        if counter1 < 9 then
          counter1 <= counter1 + 1;
        else
          counter1 <= (others => '0');
        end if;
      end if;
    end if;
  end process count1;

  buildZero: process(counter1)
  begin
    if counter1 = 0 then
      counter1IsZero <= '1';
    else
      counter1IsZero <= '0';
    end if;
  end process buildZero;

  enStep <= counter1IsZero;

  count2: process(reset, clock)
  begin
    if reset = '1' then
      counter2 <= (others => '0');
    elsif rising_edge(clock) then
      if start = '1' then
        counter2 <= (others => '0');
      elsif counter1IsZero = '1' then
        counter2 <= counter2 + 1;
      end if;
    end if;
  end process count2;

  build1Hz: process(counter2, counter1IsZero)
  begin
    if counter2 = 0 then
      en1Hz <= counter1IsZero;
    else
      en1Hz <= '0';
    end if;
  end process build1Hz;


END RTL;
