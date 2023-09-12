File format is (minus the quotes, they are just here to deliniate the characters used in the line)

"Delay	ProcessorPinStatuses	Address	Data -- Optional Comments"

The ProcessorPinStatuses is a std_logic_vector

From left to right maps to these record properties:

type PROCESSOR_PINS_T is record
    BE      : std_logic;
    IRQB    : std_logic;
    MLB     : std_logic;
    NMIB    : std_logic;
    RDY     : std_logic;
    RWB     : std_logic;
    SOB     : std_logic;
    SYNC    : std_logic;
    VPB     : std_logic;
...
end record PROCESSOR_PINS_T;

100011010 would map to BE = 1, RDY = 1, RWB = 1, SYNC = 1 others => 0