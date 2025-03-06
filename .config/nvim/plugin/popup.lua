local function floating_input(opts, on_confirm)
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local input = Input({
    position = {
      row = "20%",
      col = "50%",
    },
		size = {
			width = 50,
		},
		border = {
			style = "rounded",
			text = {
				top = opts.prompt or " Input ",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "",
		default_value = opts.default,
		on_close = function()
			on_confirm(nil)
		end,
		on_submit = function(value)
			on_confirm(value)
		end,
	})

	input:mount()

	input:on(event.BufLeave, function()
		input:unmount()
	end)

	return input
end

vim.ui.input = function(opts, on_confirm)
	floating_input(opts, on_confirm)
end
