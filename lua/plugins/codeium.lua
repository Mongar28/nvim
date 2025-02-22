return {
  "nvim-cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local codeium_enabled = true -- Variable para controlar el estado de Codeium

    -- Añadir la fuente de Codeium inicialmente
    table.insert(opts.sources, {
      name = "codeium",
      group_index = 1,
      priority = 100,
    })

    -- Función para alternar Codeium
    local function toggle_codeium()
      codeium_enabled = not codeium_enabled
      if codeium_enabled then
        table.insert(opts.sources, 1, {
          name = "codeium",
          group_index = 1,
          priority = 100,
        })
        vim.notify("Codeium activado")
      else
        -- Eliminar Codeium de las fuentes
        opts.sources = vim.tbl_filter(function(source)
          return source.name ~= "codeium"
        end, opts.sources)
        vim.notify("Codeium desactivado")
      end
      -- Recargar nvim-cmp
      cmp.setup(opts)
    end

    -- Mapeo para alternar Codeium
    vim.keymap.set("n", "<leader>tc", toggle_codeium, { desc = "Alternar Codeium" })

    -- Mapeos de teclas para nvim-cmp
    opts.mapping = cmp.mapping.preset.insert({
      ["<Down>"] = cmp.mapping.select_next_item(),       -- Siguiente
      ["<Up>"] = cmp.mapping.select_prev_item(),         -- Anterior
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar
      ["<C-e>"] = cmp.mapping.abort(),                   -- Cerrar
    })

    -- Configuración de bordes
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
  end,
}

