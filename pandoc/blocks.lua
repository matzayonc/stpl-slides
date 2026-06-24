-- dynaprez authoring conventions -> Beamer.
--
-- Blocks: a fenced div whose class is block / alert / example.
-- The title is the leading "### Heading" inside it (optional).
--
--   ::: alert
--   ### Problem
--   BFT compute bez skali to zabawka.
--   :::
--
-- Columns: a fenced div with class "columns". Columns are separated by a
-- "---" rule; each gets equal width. No inner column wrappers needed.
--
--   ::: columns
--   ::: block
--   ### Order Book (CEX)
--   - ...
--   :::
--   ---
--   ::: block
--   ### AMM (DEX)
--   - ...
--   :::
--   :::

local env_of = {
  block = "block",
  alert = "alertblock",    alertblock   = "alertblock",
  example = "exampleblock", exampleblock = "exampleblock",
}

-- Render a list of inlines (a block title) to a LaTeX string, keeping any
-- inline formatting and math intact.
local function inlines_to_latex(inlines)
  local s = pandoc.write(pandoc.Pandoc({ pandoc.Plain(inlines) }), "latex")
  return (s:gsub("%s+$", ""))
end

local function wrap_block(env, content)
  local title = ""
  if content[1] and content[1].t == "Header" then
    title = inlines_to_latex(content[1].content)
    table.remove(content, 1)
  end
  local out = { pandoc.RawBlock("latex", "\\begin{" .. env .. "}{" .. title .. "}") }
  for _, b in ipairs(content) do out[#out + 1] = b end
  out[#out + 1] = pandoc.RawBlock("latex", "\\end{" .. env .. "}")
  return out
end

-- Convert a single div to its LaTeX blocks, or nil if it carries no known class.
local function convert(el)
  for _, cls in ipairs(el.classes) do
    if env_of[cls] then
      return wrap_block(env_of[cls], el.content)
    end
  end
  return nil
end

-- Emit one column's worth of blocks (a slice of the columns body), converting
-- any nested block divs along the way.
local function emit_column(blocks, width, out)
  out[#out + 1] = pandoc.RawBlock("latex", "\\begin{column}{" .. width .. "\\textwidth}")
  for _, b in ipairs(blocks) do
    local converted = (b.t == "Div") and convert(b) or nil
    if converted then
      for _, c in ipairs(converted) do out[#out + 1] = c end
    else
      out[#out + 1] = b
    end
  end
  out[#out + 1] = pandoc.RawBlock("latex", "\\end{column}")
end

local function is_columns(el)
  for _, cls in ipairs(el.classes) do
    if cls == "columns" then return true end
  end
  return false
end

local function handle_div(el)
  if is_columns(el) then
    -- Split children into column groups on HorizontalRule.
    local groups, cur = {}, {}
    for _, b in ipairs(el.content) do
      if b.t == "HorizontalRule" then
        groups[#groups + 1] = cur; cur = {}
      else
        cur[#cur + 1] = b
      end
    end
    groups[#groups + 1] = cur
    local width = string.format("%.2f", 0.96 / #groups)
    local out = { pandoc.RawBlock("latex", "\\begin{columns}[T]") }
    for _, g in ipairs(groups) do emit_column(g, width, out) end
    out[#out + 1] = pandoc.RawBlock("latex", "\\end{columns}")
    return out
  end
  return convert(el)
end

-- Top-down so we own traversal of columns before their inner blocks convert.
return {
  {
    traverse = "topdown",
    Div = function(el)
      local result = handle_div(el)
      if result then return result, false end
    end,
  },
}
