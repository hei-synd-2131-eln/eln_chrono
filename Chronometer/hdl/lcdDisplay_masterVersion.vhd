library Common;
  use Common.CommonLib.all;

ARCHITECTURE masterVersion OF lcdDisplay IS

  constant displaySequenceLength: positive := 79;
  type displayDataType is array (1 to displaySequenceLength+1)
    of natural;
  constant displayData: displayDataType :=(
    character'pos(can), -- cancel (clear display)
    character'pos(stx), -- start of text (pos 0,0)
    character'pos('H'), -- Line 1
    character'pos('E'),
    character'pos('S'),
    character'pos('-'),
    character'pos('S'),
    character'pos('O'),
    character'pos('/'),
    character'pos('/'),
    character'pos('V'),
    character'pos('a'),
    character'pos('l'),
    character'pos('a'),
    character'pos('i'),
    character'pos('s'),
    character'pos(' '),
    character'pos('W'),
    character'pos('a'),
    character'pos('l'),
    character'pos('l'),
    character'pos('i'),
    character'pos('s'),
    character'pos(' '),
    character'pos(cr),
    character'pos(lf),
    character'pos('-'), -- Line 2
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos('-'),
    character'pos(cr),
    character'pos(lf),
    character'pos('S'), -- Line 3
    character'pos('e'),
    character'pos('m'),
    character'pos('e'),
    character'pos('s'),
    character'pos('t'),
    character'pos('e'),
    character'pos('r'),
    character'pos('p'),
    character'pos('r'),
    character'pos('o'),
    character'pos('j'),
    character'pos('e'),
    character'pos('c'),
    character'pos('t'),
    character'pos(cr),
    character'pos(lf),
    character'pos('C'), -- Line 4
    character'pos('h'),
    character'pos('r'),
    character'pos('o'),
    character'pos('n'),
    character'pos('o'),
    character'pos('m'),
    character'pos('e'),
    character'pos('t'),
    character'pos('e'),
    character'pos('r'),
    character'pos(stx),  -- start of text (pos 0,0)
    character'pos('-')
  );

  signal sequenceCounter: unsigned(requiredBitNb(displaySequenceLength+1)-1 downto 0);
  signal sequenceDone: std_ulogic;

BEGIN

  ------------------------------------------------------------------------------
                                                     -- display sequence counter
  countDisplaySequence: process(reset, clock) 
	begin
    if reset='1' then
			sequenceCounter <= to_unsigned(1, sequenceCounter'length);
    elsif rising_edge(clock) then
      if (sequenceDone = '1') then
  			sequenceCounter <= to_unsigned(1, sequenceCounter'length);
      elsif busy = '0' then
        if sequenceDone = '0' then
          sequenceCounter <= sequenceCounter + 1;
        end if;
      end if;
    end if;
  end process countDisplaySequence;

  sequenceDone <= '1' when sequenceCounter > displaySequenceLength
    else '0';

  ------------------------------------------------------------------------------
                                                               -- output control
	ascii <= std_ulogic_vector(to_unsigned(
    displayData(to_integer(sequenceCounter)), ascii'length
  )) when (sequenceCounter > 0)
    else (others => '-');
	send <= not busy when sequenceDone = '0'
	  else '0';

END ARCHITECTURE masterVersion;