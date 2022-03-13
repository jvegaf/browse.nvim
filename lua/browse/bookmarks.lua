local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local bookmars = {
  { "lualine", "https://github.com/hoob3rt/lualine.nvim" },
  { "neovim", "https://github.com/neovim/neovim" },
  { "neovim-discource", "https://neovim.discourse.group/" },
  { "nvim-telescope", "https://github.com/nvim-telescope/telescope.nvim" },
  { "awesome-neovim", "https://github.com/rockerBOO/awesome-neovim" },
  { "B2BOrdersWorkflowServer", "https://github.com/koinearth/B2BOrdersWorkflowServer" },
  { "dNotes", "https://github.com/lalitmee/dNotes" },
  { "dotfiles", "https://github.com/lalitmee/dotfiles" },
  { "marketsn-api-service", "https://github.com/koinearth/marketsn-api-service" },
  { "marketsn-pdf-service", "https://github.com/koinearth/marketsn-pdf-service" },
  { "marketsn-pwa-service", "https://github.com/koinearth/marketsn-pwa-service" },
  { "marketsn-webapp-service", "https://github.com/koinearth/marketsn-webapp-service-nextjs" },
  { "material-ui", "https://material-ui.com/" },
  { "material-ui-icons", "https://material-ui.com/components/material-icons/#material-icons" },
  { "my-pull-requests", "https://github.com/pulls" },
  { "wf-pwa-service", "https://github.com/koinearth/wf-pwa-service" },
  { "wf-webapp-service", "https://github.com/koinearth/wf-webapp-service" },
}

-- our picker function: colors
M.search_bookmarks = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Bookmarks",
    finder = finders.new_table({
      results = bookmars,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[2],
          ordinal = entry[2],
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local search_url = selection["display"]
        -- print(selection["display"])
        vim.fn.jobstart(string.format("xdg-open '%s'", search_url))
      end)
      return true
    end,
  }):find()
end

return M