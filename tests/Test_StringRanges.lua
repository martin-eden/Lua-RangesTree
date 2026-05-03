-- Ranges Tree test for string ranges

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

local create_string_value = request('StringValue.create')
local create_ranges_tree = request('RangesTree.create')
local create_range = request('Range.create')
local apply_ranges = request('apply_ranges')

--[[
  We will test multi-values composition in tree

  Example:

    ~1234--56789=
     ~~~~  ~~~~~  -- Part
      ~ ~   ~ ~   -- Part.Even
        ~   ~     -- Part.Even.Middle
]]

local test_str = '~1234--56789='

local InputData = create_string_value(test_str)
local StringFields = create_ranges_tree()
local OutputData

print('<Input>: ' .. InputData:GetValue())

StringFields:AddNameAndRanges(
  'Part',
  {
    create_range(2, 4),
    create_range(8, 5),
  }
)

OutputData = create_string_value()
apply_ranges(InputData, StringFields:GetRanges('Part'), OutputData)
print('Part: ' .. OutputData:GetValue())

StringFields:AddNameAndRanges(
  'Part.Even',
  {
    create_range(2, 1),
    create_range(4, 1),
    create_range(6, 1),
    create_range(8, 1),
  }
)

OutputData = create_string_value()
apply_ranges(InputData, StringFields:GetRanges('Part.Even'), OutputData)
print('Part.Even: ' .. OutputData:GetValue())

StringFields:AddNameAndRange('Part.Even.Middle', create_range(2, 2))

OutputData = create_string_value()
apply_ranges(InputData, StringFields:GetRanges('Part.Even.Middle'), OutputData)
print('Part.Even.Middle: ' .. OutputData:GetValue())

-- print(t2s(InputData))
-- print(t2s(StringFields))
-- print(t2s(OutputData))

--[[
  2026-04-30
  2026-05-01
  2026-05-02
  2026-05-03
]]
