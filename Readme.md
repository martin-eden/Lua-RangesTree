[![DeepWiki][DeepWiki_Logo]][DeepWiki_Repo] (sometimes AI explains it better)

## What

(2026-05)

Lua module for ranges tree structure.

Tree contains nested named ranges and provides method to resolve
node ranges to tree root's frame.


## Usage

(Below is annotated current example from ["Getting string"][string_test].)

Okay, you have string with fixed data layout:
`~` `1` `2` `3` `4` `-` `-` `5` `6` `7` `8` `9` `=`

There is "real data" part with digits. You need to get two middle characters
that are at even positions in "real data" part.

Preparation and printing of initial "raw data".

```Lua
local create_value = request('StringValue.Interface').create
local create_ranges_tree = request('RangesTree.Interface').create
local create_range = request('Range.Interface').create
local apply_ranges = request('apply_ranges')

local test_str = '~1234--56789='

local InputData = create_value()
InputData:SetValue(test_str)

local StringFields = create_ranges_tree()
local OutputData

print('<Input>: ' .. InputData:GetValue())
```

Creating `Part`, `Part.Even` and `Part.Even.Middle` range nodes.

```Lua
StringFields:AddNameAndRanges(
  'Part',
  {
    create_range(2, 4),
    create_range(8, 5),
  }
)

StringFields:AddNameAndRanges(
  'Part.Even',
  {
    create_range(2, 1),
    create_range(4, 1),
    create_range(6, 1),
    create_range(8, 1),
  }
)

StringFields:AddNameAndRange('Part.Even.Middle', create_range(2, 2))
```
Note that nested node ranges does not depend from parent's ranges.
Arguments for `create_range()` are starting index (from 1) and length.

We are using two convenience functions `AddNameAndRanges()` and
`AddNameAndRange()`. But core functions are `AddName()` and `AddRange()`.


Getting and printing our "two middle even chars from essential data":

```Lua
OutputData = create_string_value()
apply_ranges(InputData, StringFields:GetRanges('Part.Even.Middle'), OutputData)
print('Part.Even.Middle: ' .. OutputData:GetValue())
```

Complete example's output:
```
<Input>: ~1234--56789=
Part: 123456789
Part.Even: 2468
Part.Even.Middle: 46
```

## Notes

* Ranges tree does not store any data. It stores ranges map for fields.
  Real data is read only from `apply_ranges()`.

  This means you can use created ranges mask for any other data
  in same format. No need to recreate tree nodes.


## Code

  * [`src/`][src]
  * Examples
    * [Getting string][string_test]
    * [Getting bits][bits_test]


## Requirements

  * Lua v5.3


## Install/remove

  * Clone repo/delete directory


## See also

* [`workshop`][workshop] -- My personal Lua framework
* [My other repositories][contents]


[DeepWiki_Logo]: https://deepwiki.com/badge.svg
[DeepWiki_Repo]: https://deepwiki.com/martin-eden/Lua-RangesTree

[src]: src/
[string_test]: tests/Test_StringRanges.lua
[bits_test]: tests/Test_BitsRanges.lua
[workshop]: https://github.com/martin-eden/workshop
[contents]: https://github.com/martin-eden/contents
