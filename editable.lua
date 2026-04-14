local fmico = "icon16/%s.png"
local nvico = "accept"
local dfkey = "main"
local dfico = "icon"
local wpkey = "__editableOrderInfo"
local wpfnc = function(v) return v end

-- https://wiki.facepunch.com/gmod/Silkicons
-- https://heyter.github.io/js-famfamfam-search/
local function wrapGetIcon(icon)
  return fmico:format(tostring(icon or nvico))
end

--[[
 * Returns the entity editable key
]]
local function wrapGetInfo(ent)
  if(not IsValid(ent)) then return end
  local etab = ent:GetTable()
  local info = etab[wpkey]; if(not info) then
    etab[wpkey] = {N = 0, T = {}, E = {}}
  end; info = etab[wpkey]; return info
end

--[[
 * Retrieves entity order settings for the given key
 * ent > Entity to register as primary laser source
 * https://github.com/Facepunch/garrysmod/lua/includes/extensions/entity.lua
]]
local function wrapGetOrder(ent, key)
  if(not key) then return end
  local info = wrapGetInfo(ent)
  if(not info) then return end
  local itab = info.T -- Red the type
  local ikey = itab[key] -- Index key
  itab[key] = (ikey and (ikey + 1) or 0)
  info.N = (info.N + 1) -- Increment
  return key, info.N, itab[key], info.E
end

--[[
 * Extracts table value content from 2D set specified key
 * tab > Reference to a table of row tables (list.Get)
 * idx > The key to be extracted (mandatory)
 *   table  : Assign convert for all the values
 *   direct : Direct translate 2:n from single
 *   [key]  : Extract dedicated from row[idx]
 * fnc > Conversion function. Defaults to `wpfnc`
]]
local function wrapConvert(tab, idx, fnc)
  if(not tab) then return end
  if(not idx) then return end
  local set, fnc = {}, (fnc or wpfnc)
  if(istable(idx)) then -- Index table
    for k, v in pairs(idx) do set[k] = fnc(v) end
  else -- The index is a value. Index table
    if(tostring(idx):sub(1, 1) == "#") then
      local r = tostring(idx):sub(2, -1)
      local o = (r:len() > 0 and r or nil)
      for k, v in pairs(tab) do set[k] = fnc(o) end
    else
      for k, v in pairs(tab) do set[k] = fnc(v[idx]) end
    end
  end; return set -- Key-value pairs
end

-- https://wiki.facepunch.com/gmod/Editable_Entities
--[[
 * trn > Display a translated string instead of editable name
 * ron > Enable or disable read-only. Cannot edit when enabled
 * def > Default text value when nothing in combo selected
 * sek > The key being automatically selected on creation
]]
function ENT:EditableSetName(trn, ron)
  local info = wrapGetInfo(ent)
  if(not info) then return self end
  local ro = ((ron ~= nil) and tobool(ron) or false)
  local na = ((trn ~= nil) and tostring(trn or "") or nil)
  table.Merge(info.E, {title = na, readonly = ro}, true)
  return self
end

--[[
 * def > Default text value when nothing in combo selected
 * sek > The key being automatically selected on creation
]]
function ENT:EditableSetCombo(def, sek)
  local info = wrapGetInfo(ent)
  if(not info) then return self end
  local se = ((sek ~= nil) and sek or nil)
  local df = ((def ~= nil) and tostring(def or "") or nil)
  table.Merge(info.E, {select = se, text = df}, true)
  return self
end

--[[
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
]]
function ENT:EditableSetVector(name, catg)
  local typ, ord, id, ed = wrapGetOrder(self, "Vector")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = typ
  }, ed, true)}); return self
end

--[[
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
]]
function ENT:EditableSetVectorColor(name, catg)
  local typ, ord, id, ed = wrapGetOrder(self, "Vector")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = typ.."Color"
    }, ed, true)}); return self
end

--[[
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
]]
function ENT:EditableSetBool(name, catg)
  local typ, ord, id, ed = wrapGetOrder(self, "Bool")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = typ
  }, ed, true)}); return self
end

--[[
 * Creates floating point value selection slider
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
 * min  > Minimum value available for the number selected
 * max  > Maximum value available for the number selected
]]
function ENT:EditableSetFloat(name, catg, min, max)
  local typ, ord, id, ed = wrapGetOrder(self, "Float")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = typ,
      min      = min,
      max      = max
  }, ed, true)}); return self
end

--[[
 * Creates combo box with integer values
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
 * vals > Value selection set returned by `list.Get`
 * key  > The key used to extract the selection value
 * ico  > The key used to extract the selection icon
]]
function ENT:EditableSetFloatCombo(name, catg, vals, key, ico)
  local vas = wrapConvert(vals, (key or dfkey), tonumber) -- Use provided
  local vco = wrapConvert(vals, (ico or dfico), wrapGetIcon)
  local typ, ord, id, ed = wrapGetOrder(self, "Float")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = "Combo",
      icons    = vco,
      values   = vas
  }, ed, true)}); return self
end

--[[
 * Creates integer value selection slider
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
 * min  > Minimum value available for the number selected
 * max  > Maximum value available for the number selected
]]
function ENT:EditableSetInt(name, catg, min, max)
  local typ, ord, id, ed = wrapGetOrder(self, "Int")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = typ,
      min      = min,
      max      = max
  }, ed, true)}); return self
end

--[[
 * Creates combo box with integers
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
 * vals > Value selection set returned by `list.Get`
 * key  > The key used to extract the selection value
 * ico  > The key used to extract the selection icon
]]
function ENT:EditableSetIntCombo(name, catg, vals, key, ico)
  local vas = wrapConvert(vals, (key or dfkey), tonumber) -- Use provided
  local vco = wrapConvert(vals, (ico or dfico), wrapGetIcon)
  local typ, ord, id, ed = wrapGetOrder(self, "Int")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = "Combo",
      icons    = vco,
      values   = vas
  }, ed, true)}); return self
end

--[[
 * Create general text entry
 * name  > The data table member name `Amount` for Get/Set
 * catg  > Internal data table member category `General`
 * enter > Should the text field wait for enter to be pressed
]]
function ENT:EditableSetStringGeneric(name, catg, enter)
  local typ, ord, id, ed = wrapGetOrder(self, "String")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category     = catg,
      order        = ord,
      waitforenter = tobool(enter),
      type         = "Generic"
  }, ed, true)}); return self
end

--[[
 * Creates combo box with strings
 * name > The data table member name `Amount` for Get/Set
 * catg > Internal data table member category `General`
 * vals > Value selection set returned by `list.Get`
 * key  > The key used to extract the selection value
 * ico  > The key used to extract the selection icon
]]
function ENT:EditableSetStringCombo(name, catg, vals, key, ico)
  local vas = wrapConvert(vals, (key or dfkey), tostring) -- Use provided
  local vco = wrapConvert(vals, (ico or dfico), wrapGetIcon)
  local typ, ord, id, ed = wrapGetOrder(self, "String")
  self:NetworkVar(typ, id, name, {
    KeyName = name:lower(),
    Edit = table.Merge({
      category = catg,
      order    = ord,
      type     = "Combo",
      icons    = vco,
      values   = vas
  }, ed, true)}); return self
end

--[[
 * Removes the dynamic configuration table to save space
]]
function ENT:EditableRemoveOrder()
  local etab = self:GetTable()
  etab[wpkey] = nil; return self
end
