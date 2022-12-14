-- Null LS formatters
require("user.lsp.null-ls.formatters").setup()
-- Null LS linters
require("user.lsp.null-ls.linters").setup()

-- Do not install langauge servers automatically
lvim.lsp.automatic_servers_installation = false

-- Disable formatting capability of tsserver, jsonls, html and volar
-- as we use prettier and/or eslint_d to format/fix
lvim.lsp.on_attach_callback = function(client, _)
   if client.name ~= "tsserver" and client.name ~= "jsonls" and client.name ~= "html" and client.name ~= "volar" then
      return
   end

   client.server_capabilities.document_formatting = false
   client.server_capabilities.document_range_formatting = false
end
