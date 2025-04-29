-- our picker function: colors
-- local colors = function(opts)
--   opts = opts or {}
--   pickers.new(opts, {
--     prompt_title = "colors",
--     finder = finders.new_table {
--       results = { "red", "green", "blue" }
--     },
--     sorter = conf.generic_sorter(opts),
--   }):find()
-- end
--
-- -- to execute the function
-- colors()
-- pretty(require'telescope.builtin'.help_tags)

Picker:new{
  prompt_title            = "",
  finder                  = FUNCTION, -- see lua/telescope/finders.lua
  sorter                  = FUNCTION, -- see lua/telescope/sorters.lua
  previewer               = FUNCTION, -- see lua/telescope/previewers/previewer.lua
  selection_strategy      = "reset", -- follow, reset, row
  border                  = {},
  borderchars             = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  default_selection_index = 1, -- Change the index of the initial selection row
}
