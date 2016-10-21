return {
    -- Concat recursevly all values from given tables
    merge = function(...)
        local dump = {}

        local function copy(from, to)
            for _, value in pairs(from) do
                if type(value) == "table" then
                    copy(value, to)
                else
                    table.insert(to, value)
                end
            end
        end

        while #arg > 0 do
            copy(arg[1], dump)
            table.remove(arg, 1)
        end

        return dump
    end
}
