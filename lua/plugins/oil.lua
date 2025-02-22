return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>o",
      function()
        require("oil").open()
      end,
      desc = "[F]ormat buffer",
    },
    -- Añadimos un nuevo keymap para el split con Ctrl + Shift + S
    {
      "<C-S-s>",
      function()
        require("oil").actions.select({ vertical = true })
      end,
      desc = "Open the entry in a vertical split",
    },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      -- Aquí deshabilitamos el mapeo predeterminado de <C-s> para evitar conflicto
      ["<C-s>"] = false, -- Deshabilitar la acción predeterminada de Ctrl + S
      ["<C-S-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    },
    -- Añadimos el delete_to_trash y force_delete
    delete_to_trash = true, -- Usa la papelera de reciclaje
    force_delete = true, -- Elimina directorios no vacíos sin preguntar
  },
}
