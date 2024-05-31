local jdtls_path = vim.fn.expand '~/.local/share/nvim/mason/packages/jdtls/bin/'
local jdtls = vim.fn.resolve(jdtls_path .. '/jdtls')
local lombok = vim.fn.resolve(jdtls_path .. '/lombok.jar')

return {
  {
    'mfussenegger/nvim-jdtls',
    ft = {
      'java',
    },
    enabled = function()
      return vim.fn.filereadable(jdtls) == 1
    end,
    config = function()
      local config = {
        cmd = { jdtls, '--jvm-arg=-javaagent:' .. lombok, ' --jvm-arg=-Xbootclasspath/a:' .. lombok },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end,
  },
}
