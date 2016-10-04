-- Pack modules in custom namespaces
return {
    print = require("lib.printf"),
    concat_tables = require("lib.table_modifiers"),
    sprite = require("lib.animations")
}
