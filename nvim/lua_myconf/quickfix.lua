
-- GENERIC UTILS
--  euugh... surely lua has a built-in?!?!
function table_contains(tbl, x)
    found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
        end
    end
    return found
end

-- Show quickfix buffer when launching with "-q" on cmd line:
if table_contains(vim.v.argv, "-q") then
    vim.cmd("copen")
end
