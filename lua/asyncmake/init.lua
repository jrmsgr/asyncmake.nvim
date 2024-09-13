local BuildManager = require("asyncmake.build_manager")

local asyncmake = {
  configs = {},
}

local manager = BuildManager:new()

local function setup_cfg(cfg)
  if cfg.pattern == nil then
    vim.notify("No pattern defined for config", vim.log.levels.ERROR)
    return
  end

  manager:register_cfg(cfg)
  vim.api.nvim_create_autocmd("BufRead", {
    pattern = cfg.pattern,
    group = "asyncmake",
    callback = function(ev)
      manager:attach(ev.buf, cfg.name)
    end,
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    pattern = cfg.pattern,
    group = "asyncmake",
    callback = function(ev)
      manager:detach(ev.buf)
    end,
  })
end

function asyncmake.setup(opts)
  local opts = opts or {}
  for _, cfg in ipairs(opts) do
    asyncmake.configs[#asyncmake.configs] = cfg
    setup_cfg(cfg)
  end
end

return asyncmake
