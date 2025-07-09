local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local workspace_dir = vim.fn.stdpath("data") .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local function get_config_dir()
  if vim.fn.has("linux") == 1 then
    return "config_linux"
  elseif vim.fn.has("mac") == 1 then
    return "config_mac"
  else
    return "config_win"
  end
end

local config_file = vim.fn.expand(jdtls_path .. "/" .. get_config_dir())

local config = {
  cmd = {
    "java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    launcher_jar,

    "-configuration",
    config_file,

    "-data",
    workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
