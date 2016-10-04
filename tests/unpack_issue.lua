function printf(t, indent)
    local names = {}
    indent = indent or ""

    for n,g in pairs(t) do
        table.insert(names,n)
    end

    table.sort(names)

    for i, n in pairs(names) do
        local v = t[n]

        if type(v) == "table" then
            if(v == t) then -- prevent endless loop if table contains reference to itself
                print(indent..tostring(n)..": <-")
            else
                print(indent..tostring(n)..":")
                printf(v, indent.."   ")
            end
        else
            if type(v) == "function" then
                print(indent..tostring(n).."()")
            else
                print(indent..tostring(n)..": "..tostring(v))
            end
        end
    end
end

local function concat_tables(...)
    local dump = {}

    local function copy(from, to)
        for _, value in pairs(from) do
            if type(value) == "table" then
                copy(value, to)
            else
                -- TODO: properly handle functions, userdata, etc
                if type(v) ~= "number" then
                    value = tostring(value)
                end
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

local t1 = {1, 2, 3, {3.1, 3.2, 3.3}}
local t2 = {4, 5}
local t3 = {6}

local tt = {t1, t2, t3}
local t = concat_tables(tt)

printf(tt)
print("---")
printf(t)
