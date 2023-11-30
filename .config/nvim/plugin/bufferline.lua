-- bufferline
require("bufferline").setup{
  highlights = {
    buffer_selected = {
      fg = {
        attribute = 'bg',
        highlight = 'Normal'
      },
      bg = '#bdae93',
      bold = true,
    },
    buffer_visible = {
      fg = '#bdae93',
      bold = true,
    },
  },
  options = {
    show_buffer_close_icons = false,
    separator_style = "slant",
  }
}
