local typedefs = require "kong.db.schema.typedefs"

defaultHeaderPrefix = "X-Jwt-Claim-"

--- Schema for config:
-- This plugin includes a config for setting the header_prefix, and a config for setting a
-- table that will map claims to header name. Both are optional.
-- In addition, it sets up the same config parameters that are used in the jwt plugin, to configure where
-- to find the jwt. If a use configures the jwt location in the jwt plugin, the same configuration should
-- be used in this plugin, to tell the plugin where to find the jwt.

return {
    name = "jwt-claims-to-headers",
    fields = {
        {
            -- this plugin will only be applied to Services or Routes
            consumer = typedefs.no_consumer
        },
        {
            config = {
                type = "record",
                fields = {
                    {
                        header_prefix = {
                            type = "string",
                            default = defaultHeaderPrefix
                        }
                    },
                    {
                        claims_to_headers_table = {
                            type = "map",
                            default = nil,
                            -- Race condition error?
                            keys = {
                                type = "string"
                            },
                            values = {
                                type = "string"
                            }
                        }
                    },
                    {
                        uri_param_names = {
                            type = "array",
                            default = { "jwt" },
                            elements = {
                                type = "string"
                            }
                        }
                    },
                    {
                        cookie_names = {
                            type = "array",
                            default = {},
                            elements = {
                                type = "string"
                            }
                        }
                    }
                }
            }
        }
    }
}

-- ,
-- self_check = function(schema, plugin_t, dao, is_updating)
--   -- perform any custom verification
--   return true
-- end
