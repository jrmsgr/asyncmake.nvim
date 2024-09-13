local BuildManager = {}

function BuildManager:new()
  local o = { configs = {}, buffers = {} }
  setmetatable(o, self)
  self.__index = self
  return o
end

function BuildManager:register_config(cfg)
  if cfg.name == nil then
    return
  end
  if self.configs[cfg.name] == nil then
    self.configs[cfg.name] = cfg
  end
end

function BuildManager:attach(bufid, name)
  if self.buffers[bufid] == nil then
    self.buffers[bufid] = name
  else
    vim.notify(string.format("Failed to attach buffer %d: it already exists.", bufid), vim.log.levels.WARNING)
  end
end

function BuildManager:detach(bufid)
  self.buffers[bufid] = nil
end

return BuildManager
