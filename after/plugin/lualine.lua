require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'xcodehc'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 1,}},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    extensions = {'fugitive'},
}
