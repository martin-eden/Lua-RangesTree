-- Ranges Tree test for bits ranges

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

-- [[ Develop
package.path = package.path .. ';../../../?.lua'
--]]

package.path = package.path .. ';../src/?.lua'

require('workshop.base')

-- Imports:
-- _G.t2s = request('!.table.as_string')

local create_bits_value = request('BitsValue.create')
local create_ranges_tree = request('RangesTree.create')
local create_range = request('Range.create')
local apply_ranges = request('apply_ranges')

--[[
  We will test multi-range value composition

  Using "nibbles" concept (nibble is aligned 4-bits part).

  Example:

    41 52 63  (hex bytes)
     ~  ~  ~  -- low nibbles
    ~  ~  ~   -- high nibbles
]]

local test_int = 0x635241

local InputData = create_bits_value(test_int)
local BitFields = create_ranges_tree()
local OutputData

BitFields:AddNameAndRanges(
  'LowNibbles',
  {
    create_range(1, 4),
    create_range(9, 4),
    create_range(17, 4),
  }
)

BitFields:AddNameAndRanges(
  'HighNibbles',
  {
    create_range(5, 4),
    create_range(13, 4),
    create_range(21, 4),
  }
)

OutputData = create_bits_value()
apply_ranges(InputData, BitFields:GetRanges('LowNibbles'), OutputData)
print(string.format('Low nibbles: 0x%06X', OutputData:GetValue()))

OutputData = create_bits_value()
apply_ranges(InputData, BitFields:GetRanges('HighNibbles'), OutputData)
print(string.format('High nibbles: 0x%06X', OutputData:GetValue()))

-- print(t2s(InputData))
-- print(t2s(BitFields))
-- print(t2s(OutputData))

--[[
  2026-04-30
  2026-05-01
]]
