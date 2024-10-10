
-- Status Bar
require("lualine").setup {
    options = {
        theme = "everforest", -- or "16color"
        icons_enabled = false,
        component_separators = "",
        section_separators = "",
    },
    sections = {
        -- [a|b|c...x|y|z]
        lualine_a = {"filename", "%m%r%h%w"},
        lualine_b = {"fileformat", "encoding", "filetype"},
        lualine_c = {"diagnostics"},
        lualine_x = {"branch", "diff"},
        lualine_y = {"%03.3b", "%(%)0x%02.2B"},  -- the %(%) fools lualine into interpretting %
        lualine_z = {"location", "progress", "%L"},
    },
}
