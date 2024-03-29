-- Use <tab> for completion and snippets (supertab)
-- first: disable default <tab> and <s-tab> behavior in LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- override nvim-cmp and add cmp-emoji
      table.insert(opts.sources, { name = "emoji" })

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- VsCode colorscheme: (https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu)
      -- Customization for Pmenu
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
      vim.api.nvim_set_hl(0, "Pmenu", { fg = "#6d7888", bg = "#22252A" })

      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#B5585F" })
      vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#B5585F" })

      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#fFBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#fFBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#fFBD73" })

      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#A377BF" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#A377BF" })

      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#2Ec234" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#2Ec234" })

      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#D4A959" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#D4A959" })

      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#6C8ED4" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#6C8ED4" })

      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#58B5A8" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#58B5A8" })

      vim.api.nvim_set_hl(0, "CmpNormal", { link = "Pmenu" })
      vim.api.nvim_set_hl(0, "CmpDocNormal", { link = "Pmenu" })
      vim.api.nvim_set_hl(0, "CmpCursorLine", { bg = "#3d4552" })

      cmp.setup({
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpNormal,FloatBorder:Pmenu,CursorLine:CmpCursorLine",
            side_padding = 1,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDocNormal,FloatBorder:Pmenu",
            side_padding = 1,
          },
        },
      })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
