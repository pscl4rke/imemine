
-- Opening "tabs"
vim.keymap.set("n", "gO", "<cmd>edit .<enter>")  -- NetRW or equiv
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
vim.keymap.set("n", "g/", function()
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query) -- shortcut for vim.api.nvim_command
end)

-- Switching left and right
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")

-- Closing "tabs"
--vim.keymap.set("n", "ZQ", "<cmd>bdelete<enter>")  -- should this autodiscard (no save)?
vim.keymap.set("n", "ZQ", "<cmd>bdelete!<enter>")  -- never save
vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>") -- always save

require("bufferline").setup {
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
    }
}
