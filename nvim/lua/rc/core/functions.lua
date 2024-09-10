function CopyBufferPathToClipboard()
  local buffer_path = vim.fn.expand('%:p')  -- Get the full path of the current buffer
  vim.fn.setreg('+', buffer_path)  -- Copy the path to the clipboard
end
